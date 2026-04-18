"""
Test module: XAUUSD data sources
- APISed API: realtime price (1s tick)
- TradingView WS: historical OHLCV candles (M1, M5, M15, H1)

Run:  python test_tradingview.py
"""

import json
import random
import string
import re
import time
import threading
from datetime import datetime, timezone

import httpx
import websocket

# ---------------------------------------------------------------
# CONFIG
# ---------------------------------------------------------------

APISED_KEY = "sk_c27869e90912e2A4f32E104A77Ad9dFC02bb47B5e489f4cE"
APISED_URL = "https://gold.g.apised.com/v1/latest?metals=XAU&base_currency=USD&currencies=USD&weight_unit=TOZ"

TV_WS_URL = "wss://data.tradingview.com/socket.io/websocket"
TV_HEADERS = {
    "Origin": "https://data.tradingview.com",
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36"
}
TV_SYMBOL = "OANDA:XAUUSD"

TF_MAP = {
    "1":  {"label": "1min",  "default_bars": 1500},
    "5":  {"label": "5min",  "default_bars": 500},
    "15": {"label": "15min", "default_bars": 300},
    "60": {"label": "1hour", "default_bars": 200},
}


# ---------------------------------------------------------------
# TRADINGVIEW WEBSOCKET PROTOCOL
# ---------------------------------------------------------------

def _rand_id(prefix, length=12):
    return prefix + "".join(random.choice(string.ascii_lowercase) for _ in range(length))


def _pack(msg):
    return f"~m~{len(msg)}~m~{msg}"


def _tv_send(ws, method, params):
    ws.send(_pack(json.dumps({"m": method, "p": params}, separators=(",", ":"))))


def _parse_packets(raw):
    results = []
    pattern = re.compile(r"~m~(\d+)~m~")
    pos = 0
    while pos < len(raw):
        m = pattern.match(raw, pos)
        if not m:
            break
        length = int(m.group(1))
        start = m.end()
        results.append(raw[start:start + length])
        pos = start + length
    return results


def _extract_candles(params):
    candles = []
    for p in params:
        if not isinstance(p, dict):
            continue
        for key, val in p.items():
            bars = None
            if isinstance(val, dict) and "s" in val:
                bars = val["s"]
            elif isinstance(val, list):
                bars = val
            if bars:
                for bar in bars:
                    if isinstance(bar, dict) and "v" in bar:
                        v = bar["v"]
                        if len(v) >= 5:
                            candles.append({
                                "time": int(v[0]),
                                "open": round(v[1], 3),
                                "high": round(v[2], 3),
                                "low": round(v[3], 3),
                                "close": round(v[4], 3),
                                "volume": round(v[5], 2) if len(v) > 5 else 0,
                            })
    return candles


def fetch_tv_history(symbol=TV_SYMBOL, interval="1", n_bars=1500, timeout=30):
    """Fetch historical candle data from TradingView WebSocket."""
    chart = _rand_id("cs_")
    candles = []
    error = [None]
    ready = threading.Event()

    def on_message(ws, message):
        for packet in _parse_packets(message):
            if packet.startswith("~h~"):
                ws.send(_pack(packet))
                continue
            try:
                data = json.loads(packet)
            except Exception:
                continue
            if not isinstance(data, dict) or "m" not in data:
                continue
            m = data["m"]
            p = data.get("p", [])
            if m in ("timescale_update", "du"):
                candles.extend(_extract_candles(p))
            elif m == "series_completed":
                ready.set()
            elif m in ("protocol_error", "critical_error"):
                error[0] = str(p)
                ready.set()

    def on_open(ws):
        _tv_send(ws, "set_auth_token", ["unauthorized_user_token"])
        _tv_send(ws, "chart_create_session", [chart, ""])
        _tv_send(ws, "switch_timezone", [chart, "Etc/UTC"])
        _tv_send(ws, "resolve_symbol", [
            chart, "sds_sym_1",
            f'={{"symbol":"{symbol}","adjustment":"splits","session":"regular"}}'
        ])
        _tv_send(ws, "create_series", [
            chart, "sds_1", "s1", "sds_sym_1", interval, n_bars, ""
        ])

    def on_error(ws, err):
        error[0] = str(err)
        ready.set()

    ws_app = websocket.WebSocketApp(
        TV_WS_URL,
        header=[f"{k}: {v}" for k, v in TV_HEADERS.items()],
        on_open=on_open, on_message=on_message, on_error=on_error,
    )
    t = threading.Thread(target=ws_app.run_forever, daemon=True)
    t.start()
    ready.wait(timeout=timeout)
    ws_app.close()

    if error[0]:
        return None, error[0]

    # Deduplicate and sort by time
    seen = set()
    unique = []
    for c in candles:
        if c["time"] not in seen:
            seen.add(c["time"])
            unique.append(c)
    unique.sort(key=lambda x: x["time"])
    return unique, None


# ---------------------------------------------------------------
# TEST
# ---------------------------------------------------------------

def format_time(ts):
    """Convert Unix timestamp to readable datetime."""
    return datetime.fromtimestamp(ts, tz=timezone.utc).strftime("%Y-%m-%d %H:%M")


def run_test(interval="5", n_bars=20):
    """Test fetch data for 1 timeframe."""
    tf_info = TF_MAP.get(interval, {"label": f"{interval}m", "default_bars": n_bars})
    print(f"\n{'='*60}")
    print(f"  Test: {TV_SYMBOL} | TF: {tf_info['label']} | Bars: {n_bars}")
    print(f"{'='*60}")

    start = time.time()
    candles, err = fetch_tv_history(
        symbol=TV_SYMBOL,
        interval=interval,
        n_bars=n_bars,
        timeout=15,
    )
    elapsed = time.time() - start

    if err:
        print(f"  [FAIL] Error: {err}")
        return False

    if not candles:
        print(f"  [FAIL] No data received (timeout or empty)")
        return False

    print(f"  [OK] Received {len(candles)} candles in {elapsed:.1f}s")
    print(f"  Range: {format_time(candles[0]['time'])} -> {format_time(candles[-1]['time'])}")
    print()

    # Show first 5 and last 5 candles
    display = candles[:5] + [None] + candles[-5:] if len(candles) > 10 else candles
    print(f"  {'Time':>18}  {'Open':>10}  {'High':>10}  {'Low':>10}  {'Close':>10}  {'Vol':>8}")
    print(f"  {'-'*18}  {'-'*10}  {'-'*10}  {'-'*10}  {'-'*10}  {'-'*8}")
    for c in display:
        if c is None:
            print(f"  {'... (skipped) ...':^70}")
            continue
        print(f"  {format_time(c['time']):>18}  {c['open']:>10.3f}  {c['high']:>10.3f}  "
              f"{c['low']:>10.3f}  {c['close']:>10.3f}  {c['volume']:>8.0f}")

    # Validate data
    last = candles[-1]
    if last["close"] < 1000 or last["close"] > 5000:
        print(f"\n  [WARN] Abnormal close price: {last['close']} (outside 1000-5000)")
    else:
        print(f"\n  [OK] Gold price ~ ${last['close']:.2f}/oz")

    return True


def test_apised(n_ticks=5, interval=1.0):
    """Test APISed API realtime price (1s tick)."""
    print(f"\n{'='*60}")
    print(f"  Test: APISed API | {n_ticks} ticks | interval {interval}s")
    print(f"{'='*60}")

    ticks = []
    with httpx.Client(timeout=5.0) as client:
        for i in range(n_ticks):
            try:
                t1 = time.time()
                resp = client.get(APISED_URL, headers={"x-api-key": APISED_KEY})
                latency = round((time.time() - t1) * 1000)
                data = resp.json()

                if data.get("status") != "success":
                    print(f"  Tick {i+1}: [FAIL] status={data.get('status')}")
                    continue

                price = float(data["data"]["metal_prices"]["XAU"]["price"])
                now = datetime.now().strftime("%H:%M:%S")
                ticks.append({"price": price, "latency": latency, "time": now})
                print(f"  Tick {i+1}: ${price:.2f}  (latency: {latency}ms)  [{now}]")

            except Exception as e:
                print(f"  Tick {i+1}: [ERROR] {e}")

            if i < n_ticks - 1:
                time.sleep(interval)

    if len(ticks) < 2:
        print(f"\n  [FAIL] Only {len(ticks)} tick(s) received")
        return False

    # Stats
    prices = [t["price"] for t in ticks]
    latencies = [t["latency"] for t in ticks]
    price_diff = max(prices) - min(prices)
    avg_latency = sum(latencies) / len(latencies)

    print(f"\n  Price range: ${min(prices):.2f} - ${max(prices):.2f} (diff: ${price_diff:.2f})")
    print(f"  Avg latency: {avg_latency:.0f}ms")
    print(f"  [OK] APISed realtime tick working!")
    return True


def main():
    print()
    print("=" * 60)
    print("  XAUUSD Data Sources Test")
    print("  1) APISed API  -> realtime price (1s tick)")
    print("  2) TradingView -> OHLCV candles (M1/M5/M15/H1)")
    print("=" * 60)

    results = {}

    # --- Part 1: APISed realtime price ---
    print(f"\n{'='*60}")
    print("  PART 1: APISed API (realtime 1s tick)")
    print(f"{'='*60}")
    results["APISed"] = test_apised(n_ticks=5, interval=1.0)

    # --- Part 2: TradingView OHLCV ---
    print(f"\n{'='*60}")
    print("  PART 2: TradingView WS (OHLCV candles)")
    print(f"{'='*60}")
    for tf in ["1", "5", "15", "60"]:
        ok = run_test(interval=tf, n_bars=20)
        results[f"TV_{tf}"] = ok

    # Summary
    print(f"\n{'='*60}")
    print("  SUMMARY")
    print(f"{'='*60}")

    labels = {
        "APISed": "APISed 1s tick",
        "TV_1": "TV M1 OHLCV",
        "TV_5": "TV M5 OHLCV",
        "TV_15": "TV M15 OHLCV",
        "TV_60": "TV H1 OHLCV",
    }
    for key, ok in results.items():
        status = "PASS" if ok else "FAIL"
        print(f"  {labels.get(key, key):>16}: [{status}]")

    total_pass = sum(1 for v in results.values() if v)
    total = len(results)
    print(f"\n  Result: {total_pass}/{total} tests OK")


if __name__ == "__main__":
    main()

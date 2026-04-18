// lib/core/models/exchange_app.dart

class ExchangeApp {
  final String name;
  final String iconPath;
  final String url;

  ExchangeApp({required this.name, required this.iconPath, required this.url});

  factory ExchangeApp.fromMap(Map<String, dynamic> map) {
    return ExchangeApp(
      name: map['name'] ?? '',
      iconPath: map['iconPath'] ?? '',
      url: map['url'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'iconPath': iconPath,
      'url': url,
    };
  }
}

final List<ExchangeApp> allExchangeApps = [
  ExchangeApp(name: 'XM', iconPath: 'assets/icons/xm.png', url: 'https://affs.click/0mg8B'),
  ExchangeApp(name: 'Axi', iconPath: 'assets/icons/axi.png', url: 'https://www.axi.com/int/live-account?promocode=4736137'),
  ExchangeApp(name: 'Vantagemarkets', iconPath: 'assets/icons/vantagemarkets.png', url: 'https://vigco.co/la-com/vi/signalgpt'),
  ExchangeApp(name: 'XTB', iconPath: 'assets/icons/xtb.png', url: 'https://geolink.xtb.com/aJSfg'),
  ExchangeApp(name: 'Exness', iconPath: 'assets/icons/exness.png', url: 'https://www.extrading.asia/vi/?utm_source=partners&ex_ol=1'),
  ExchangeApp(name: 'LiteFinance', iconPath: 'assets/icons/LiteFinance.png', url: 'https://litefinance.com.vn/?uid=742903029&cid=336726'),
  ExchangeApp(name: 'OKX', iconPath: 'assets/icons/okx.png', url: 'https://minvest.vn/OKX'),
  ExchangeApp(name: 'Bybit', iconPath: 'assets/icons/bybit.png', url: 'https://minvest.vn/Bybit'),
  ExchangeApp(name: 'Binance', iconPath: 'assets/icons/binance.png', url: 'https://minvest.vn/Binance'),
];

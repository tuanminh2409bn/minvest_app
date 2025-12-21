import 'package:flutter/material.dart';
import 'dart:html' as html;

class PaymentCallbackScreen extends StatelessWidget {
  final bool isSuccess;

  const PaymentCallbackScreen({super.key, required this.isSuccess});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(32),
          constraints: const BoxConstraints(maxWidth: 400),
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E1E),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isSuccess ? Icons.check_circle_outline : Icons.error_outline,
                color: isSuccess ? Colors.greenAccent : Colors.redAccent,
                size: 64,
              ),
              const SizedBox(height: 24),
              Text(
                isSuccess ? "Payment Successful" : "Payment Cancelled",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                isSuccess
                    ? "Your transaction has been completed. You can now close this tab and return to the main application."
                    : "Your transaction was cancelled. You can close this tab and try again if you wish.",
                style: const TextStyle(color: Colors.white70, fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  html.window.close();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: isSuccess ? Colors.green : Colors.grey,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: const Text("Close Tab"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

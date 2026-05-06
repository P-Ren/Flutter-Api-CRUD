import 'package:flutter/material.dart';

class ButtomCustom extends StatelessWidget {
  final String title;
  final bool isReady;
  final VoidCallback? onTap;

  const ButtomCustom({
    super.key,
    required this.title,
    required this.isReady,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: isReady ? 1.0 : 0.9,
      duration: const Duration(milliseconds: 400),
      curve: Curves.elasticOut,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: isReady ? 280 : 220,
        height: 55,
        decoration: BoxDecoration(
          // បើ Ready ប្រើពណ៌ Gradient បើអត់ទេប្រើពណ៌ប្រផេះ
          gradient: isReady
              ? const LinearGradient(colors: [Colors.amber, Colors.orange])
              : const LinearGradient(colors: [Color(0xFFE0E0E0), Color(0xFFBDBDBD)]),
          borderRadius: BorderRadius.circular(isReady ? 30 : 12),
          boxShadow: isReady
              ? [
            BoxShadow(
              color: Colors.green.withOpacity(0.4),
              blurRadius: 15,
              offset: const Offset(0, 8),
            )
          ]
              : [],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: isReady ? onTap : null,
            borderRadius: BorderRadius.circular(isReady ? 30 : 12),
            child: Center(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  letterSpacing: 1.1,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
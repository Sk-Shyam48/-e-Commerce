import 'package:flutter/material.dart';

class PromoCard extends StatelessWidget {
  final String text;
  final Color color;
  final String imagePath;

  const PromoCard({
    super.key,
    required this.text,
    required this.color,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 100,
      padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: color,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                  ),
                  onPressed: () {},
                  child: Text(
                    'Get Now',
                    style: TextStyle(color: color),
                  ),
                ),
              ],
            ),
          ),
          Image.asset(
            imagePath,
            width: 120,
            height: 120,
          ),
        ],
      ),
    );
  }
}

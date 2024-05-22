import 'package:flutter/material.dart';

class SizeOptions extends StatefulWidget {
  final List<int> sizes;
  final ValueChanged<int> onSizeSelected;

  const SizeOptions(
      {Key? key, required this.sizes, required this.onSizeSelected})
      : super(key: key);

  @override
  _SizeOptionsState createState() => _SizeOptionsState();
}

class _SizeOptionsState extends State<SizeOptions> {
  int? _selectedSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: widget.sizes.map((size) {
            final isSelected = size == _selectedSize;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedSize = size;
                });
                widget.onSizeSelected(size);
              },
              child: Container(
                margin: const EdgeInsets.only(right: 15),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Color.fromRGBO(254, 240, 234, 1)
                      : Colors.white,
                  border: Border.all(
                      color: isSelected
                          ? Color.fromRGBO(254, 240, 234, 1)
                          : Colors.grey.shade200),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  size.toString(),
                  style: TextStyle(
                    fontSize: 16,
                    color: isSelected
                        ? Color.fromRGBO(239, 104, 44, 1)
                        : Colors.black,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class TopCategories extends StatefulWidget {
  final List<IconData> iconDataList;

  const TopCategories({
    super.key,
    required this.iconDataList,
  });

  @override
  // ignore: library_private_types_in_public_api
  _TopCategoriesState createState() => _TopCategoriesState();
}

class _TopCategoriesState extends State<TopCategories> {
  int? _selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 10, 30, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Top Categories',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'SEE ALL',
                style: TextStyle(
                    color: Color.fromRGBO(239, 104, 44, 1),
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 70,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.iconDataList.length,
            itemBuilder: (context, index) {
              final isSelected = index == _selectedIndex;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                child: Container(
                  width: 50,
                  height: 50,
                  margin: EdgeInsets.fromLTRB(20, 10,
                      index == widget.iconDataList.length - 1 ? 20 : 0, 10),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Color.fromRGBO(239, 104, 44, 1)
                        : const Color.fromRGBO(243, 243, 243, 1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    widget.iconDataList[index],
                    color: isSelected
                        ? Colors.white
                        : const Color.fromRGBO(138, 131, 123, 1),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

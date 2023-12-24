import 'package:e_commerce_app/app/common/extensions/app_text_extension.dart';
import 'package:flutter/material.dart';

class ProductsPopupFilteringWidget extends StatelessWidget {
  const ProductsPopupFilteringWidget({super.key});

  @override
  Widget build(BuildContext context) {
    String selected = SortBy.releaseDate.name;

    return StatefulBuilder(builder: (context, setState) {
      return Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              selected,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w400,
              ),
            ),
            PopupMenuButton<SortBy>(
              color: Colors.white,
              elevation: 1,
              surfaceTintColor: Colors.white,
              icon: const Icon(
                Icons.keyboard_arrow_down,
                size: 20.0,
                textDirection: TextDirection.rtl,
              ),
              offset: const Offset(0, 46),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              onSelected: (SortBy choice) {
                setState(() {
                  selected = choice.name;
                });
              },
              itemBuilder: (BuildContext context) {
                return SortBy.values.map((menuOption) {
                  return PopupMenuItem<SortBy>(
                    value: menuOption,
                    child: menuOption.name
                        .asSubtitleSmall(fontWeight: FontWeight.w400),
                  );
                }).toList();
              },
            ),
          ],
        ),
      );
    });
  }
}

enum SortBy {
  price,
  releaseDate,
  alphabet,
}

extension SortByExtension on SortBy {
  String get name {
    switch (this) {
      case SortBy.price:
        return 'PRICE';
      case SortBy.releaseDate:
        return 'RELEASE DATE';
      case SortBy.alphabet:
        return 'A-Z';
    }
  }
}

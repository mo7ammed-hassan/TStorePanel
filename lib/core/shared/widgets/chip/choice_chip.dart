import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/core/shared/widgets/containers/circular_container.dart';
import 'package:t_store_admin_panel/core/utils/helpers/helper_functions.dart';

class TChoiceChip extends StatelessWidget {
  const TChoiceChip({super.key, required this.text, required this.isSelected, this.onSelected});

  final String text;
  final bool isSelected;
  final Function(bool)? onSelected;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
      child: ChoiceChip(
        avatar:
            HelperFunctions.getColor(text) != null
                ? CircularContainer(
                  width: 50,
                  height: 50,
                  backgroundColor: HelperFunctions.getColor(text)!,
                )
                : null,
        selected: isSelected,
        onSelected: onSelected,
        backgroundColor: HelperFunctions.getColor(text),
        labelStyle: TextStyle(color: isSelected ? Colors.white : null),
        shape:
            HelperFunctions.getColor(text) != null
                ? const CircleBorder()
                : null,
        label:
            HelperFunctions.getColor(text) == null
                ? Text(text)
                : const SizedBox(),
        padding:
            HelperFunctions.getColor(text) != null
                ? const EdgeInsets.all(0)
                : null,
        labelPadding:
            HelperFunctions.getColor(text) != null
                ? const EdgeInsets.all(0)
                : null,
      ),
    );
  }
}

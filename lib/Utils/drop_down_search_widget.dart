import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:hmis_geolocator/models/response_object.dart';

class DropDownSearchWidget extends StatelessWidget {
  DropDownSearchWidget(
      {Key? key,
      required this.onChanged,
      required this.selectedItem,
      this.asyncItemsFunction,
      this.enabled = false,
      required this.label})
      : super(key: key);
  bool enabled;
  final String label;
  final FormFieldSetter<ResponseObject> onChanged;
  final ResponseObject? selectedItem;
  final DropdownSearchOnFind<ResponseObject>? asyncItemsFunction;
  @override
  Widget build(BuildContext context) {
    return DropdownSearch<ResponseObject>(
      enabled: enabled,
      onChanged: onChanged,
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
            labelText: label,
            prefixIcon: const Icon(Icons.search),
            hintText: label),
      ),
      itemAsString: (item) => item.name!,
      asyncItems: asyncItemsFunction,
      popupProps: const PopupProps.menu(
        showSelectedItems: false,
        showSearchBox: true,
        title: Padding(
          padding: EdgeInsets.all(4.0),
          child: Center(child: Text('Search')),
        ),
        searchDelay: Duration(milliseconds: 200),
      ),
      validator: (value) {
        if (value == null) return 'Choose a $label';
        if (value.name == null) return 'Choose a $label';
        if (value.name!.isEmpty) return 'Choose a $label';
        return null;
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../constants/colors.dart';

class SearchBox extends StatefulWidget {
  final Function(String) onSearchTextChanged;

  const SearchBox({
    super.key,
    required this.onSearchTextChanged,
  });

  @override
  _SearchBoxState createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        controller: _searchController,
        onChanged: (newText) {
          widget.onSearchTextChanged(newText);
        },
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(0),
          prefixIcon: const Icon(
            Icons.search,
            color: tdBlack,
            size: 20,
          ),
          border: InputBorder.none,
          hintText: AppLocalizations.of(context)!.search,
          hintStyle: const TextStyle(color: tdGrey),
          prefixIconConstraints: const BoxConstraints(maxHeight: 20, minWidth: 25),
        ),
      ),
    );
  }
}

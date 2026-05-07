import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:student_cover/constants.dart';
import 'package:student_cover/widgets/input_field.dart';

class AutoCompleteInputField extends StatefulWidget {
  final ValueChanged<String> onChange;
  final Future<List<String>> Function(String) optionsGenerator;
  final String title;

  const AutoCompleteInputField({super.key, required this.onChange, required this.optionsGenerator, this.title = "Country"});

  @override
  State<AutoCompleteInputField> createState() => _AutoCompleteInputFieldState();
}

class _AutoCompleteInputFieldState extends State<AutoCompleteInputField> {
  final LayerLink _layerLink = LayerLink();
  final OverlayPortalController _overlayPortalController = OverlayPortalController();
  late TextEditingController _textEditingController;

  List<String> _allOptions = [];
  List<String> _filteredOptions = [];
  bool _isLoading = false;
  bool _suppressListener = false;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _textEditingController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _textEditingController.removeListener(_onTextChanged);
    _textEditingController.dispose();
    super.dispose();
  }

  Future<void> _onTextChanged() async {
    if (_suppressListener) return;

    final currentText = _textEditingController.text.trim();

    if (currentText.isEmpty) {
      _hideOverlay();
      return;
    }

    if (_allOptions.isEmpty) {
      setState(() => _isLoading = true);
      try {
        final data = await widget.optionsGenerator(currentText);
        _allOptions = data.map((e) => e.toString()).toList();
      } catch (_) {
        _allOptions = [];
      }
      if (!mounted) return;
      setState(() => _isLoading = false);
    }

    _filteredOptions = _allOptions.where((option) => option.toLowerCase().contains(currentText.toLowerCase())).toList();
    if (_filteredOptions.isNotEmpty) {
      if (!_overlayPortalController.isShowing) {
        _overlayPortalController.show();
      }
      setState(() {});
    } else {
      _hideOverlay();
    }
  }

  void _hideOverlay() {
    if (_overlayPortalController.isShowing) {
      _overlayPortalController.hide();
    }
    setState(() => _filteredOptions = []);
  }

  void _onItemSelected(String value) {
    _suppressListener = true;
    _textEditingController.text = value;
    _textEditingController.selection = TextSelection.collapsed(offset: value.length);
    _suppressListener = false;

    widget.onChange(value);
    _hideOverlay();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: OverlayPortal(
        controller: _overlayPortalController,
        overlayChildBuilder: (context) {
          return CompositedTransformFollower(
            link: _layerLink,
            targetAnchor: Alignment.bottomLeft,
            followerAnchor: Alignment.topLeft,
            child: Align(alignment: Alignment.topLeft, child: _buildDropdown()),
          );
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: InputField(title: widget.title, textEditingController: _textEditingController),
            ),
            if (_isLoading)
              Padding(
                padding: const EdgeInsets.only(left: 12, bottom: 12),
                child: SpinKitCircle(color: kPrimaryLight, size: 28),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown() {
    final maxItems = _filteredOptions.length > 5 ? 5 : _filteredOptions.length;
    final visibleItems = _filteredOptions.sublist(0, maxItems);

    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(12),
        shadowColor: Colors.black26,
        child: Container(
          constraints: const BoxConstraints(maxHeight: 240),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: border, width: 1),
          ),
          child: _isLoading
              ? const Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(
                    child: SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: kPrimary)),
                  ),
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: ListView.separated(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    itemCount: visibleItems.length,
                    separatorBuilder: (_, __) => Divider(height: 1, color: border.withOpacity(0.5)),
                    itemBuilder: (context, index) {
                      return _DropDownItem(
                        title: visibleItems[index],
                        searchQuery: _textEditingController.text.trim(),
                        onTap: () => _onItemSelected(visibleItems[index]),
                      );
                    },
                  ),
                ),
        ),
      ),
    );
  }
}

class _DropDownItem extends StatelessWidget {
  final String title;
  final String searchQuery;
  final VoidCallback onTap;

  const _DropDownItem({required this.title, required this.searchQuery, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(Icons.location_on_outlined, size: 18, color: textSecondary),
            const SizedBox(width: 12),
            Expanded(child: _buildHighlightedText()),
          ],
        ),
      ),
    );
  }

  /// Highlights the matching portion of the text in bold
  Widget _buildHighlightedText() {
    if (searchQuery.isEmpty) {
      return Text(title, style: const TextStyle(fontSize: 14, color: textPrimary));
    }

    final lowerTitle = title.toLowerCase();
    final lowerQuery = searchQuery.toLowerCase();
    final matchIndex = lowerTitle.indexOf(lowerQuery);

    if (matchIndex == -1) {
      return Text(title, style: const TextStyle(fontSize: 14, color: textPrimary));
    }

    final before = title.substring(0, matchIndex);
    final match = title.substring(matchIndex, matchIndex + searchQuery.length);
    final after = title.substring(matchIndex + searchQuery.length);

    return RichText(
      text: TextSpan(
        style: const TextStyle(fontSize: 14, color: textPrimary),
        children: [
          TextSpan(text: before),
          TextSpan(
            text: match,
            style: const TextStyle(fontWeight: FontWeight.w700, color: kPrimary),
          ),
          TextSpan(text: after),
        ],
      ),
    );
  }
}

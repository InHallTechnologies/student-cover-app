import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:student_cover/constants.dart';

class AutoCompleteInputField extends StatefulWidget {
  final String title;
  final Function(String) onChange;
  final Function(String) optionsGenerator;
  IconData? iconData;

  AutoCompleteInputField({super.key, required this.title, required this.onChange, required this.optionsGenerator, this.iconData});
  @override
  State<AutoCompleteInputField> createState() => _AutoCompleteInputFieldState();
}

class _AutoCompleteInputFieldState extends State<AutoCompleteInputField> with SingleTickerProviderStateMixin {
  final LayerLink _layerLink = LayerLink();
  final OverlayPortalController _overlayPortalController = OverlayPortalController();
  final TextEditingController _textEditingController = TextEditingController();
  final GlobalKey _fieldKey = GlobalKey();
  List<String> optionsList = [];
  bool _isLoading = false;

  void handleTextEditControlListener() async {
    try {
      if (_textEditingController.text.isEmpty) {
        _overlayPortalController.hide();
        return;
      }

      if (optionsList.contains(_textEditingController.text)) {
        _overlayPortalController.hide();
        return;
      }
      setState(() {
        _isLoading = true;
        optionsList = [];
      });

      List<String> options = await widget.optionsGenerator(_textEditingController.text);
      if (options.isNotEmpty && _textEditingController.text.isNotEmpty) {
        _overlayPortalController.show();
      }
      setState(() {
        optionsList = options;
      });
    } catch (e) {
      debugPrint("Something went wrong");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(handleTextEditControlListener);
  }

  @override
  void dispose() {
    _textEditingController.removeListener(handleTextEditControlListener);
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: OverlayPortal(
        controller: _overlayPortalController,
        overlayChildBuilder: (context) {
          final renderBox = _fieldKey.currentContext?.findRenderObject() as RenderBox?;
          final fieldWidth = renderBox?.size.width ?? 300;
          return CompositedTransformFollower(
            targetAnchor: Alignment.bottomLeft,
            followerAnchor: Alignment.topLeft,
            link: _layerLink,
            child: Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                height: 300,
                width: fieldWidth,
                child: ListView(
                  children: List<Widget>.generate(optionsList.getRange(0, min(20, optionsList.length)).length, (index) {
                    final option = optionsList[index];
                    return InkWell(
                      onTap: () {
                        _textEditingController.removeListener(handleTextEditControlListener);
                        _textEditingController.text = option;
                        _overlayPortalController.hide();
                        widget.onChange(option);
                        _textEditingController.addListener(handleTextEditControlListener);
                      },
                      splashColor: kPrimaryLight.withValues(alpha: 0.08),
                      highlightColor: kPrimaryLight.withValues(alpha: 0.05),
                      child: AutoCompleterItem(
                        option: option,
                        searchKeyword: _textEditingController.text,
                        fieldWidth: fieldWidth,
                        iconData: widget.iconData,
                      ),
                    );
                  }),
                ),
              ),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 4, bottom: 8),
              child: Text(
                widget.title,
                style: const TextStyle(color: textPrimary, fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 0.3),
              ),
            ),
            TextField(
              key: _fieldKey,
              onChanged: widget.onChange,
              controller: _textEditingController,
              cursorColor: kPrimary,
              decoration: kAuthenticationInputDecoration.copyWith(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0),
                  ),
                ),
                hintText: "Enter ${widget.title}",
                prefixIcon: SizedBox.shrink(),
                prefixIconConstraints: BoxConstraints.tight(Size(20, 10)),
                suffixIcon: _isLoading ? SizedBox(width: 20, child: SpinKitFadingCircle(color: kPrimaryDark, size: 20)) : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AutoCompleterItem extends StatelessWidget {
  const AutoCompleterItem({super.key, required this.option, required this.searchKeyword, required this.fieldWidth, this.iconData});
  final String option;
  final String searchKeyword;
  final double fieldWidth;
  final IconData? iconData;

  @override
  Widget build(BuildContext context) {
    // Case-insensitive index search, preserves original casing in display
    final int matchIndex = option.toLowerCase().indexOf(searchKeyword.toLowerCase());
    final bool hasMatch = matchIndex != -1;

    final String before = hasMatch ? option.substring(0, matchIndex) : option;
    final String match = hasMatch ? option.substring(matchIndex, matchIndex + searchKeyword.length) : '';
    final String after = hasMatch ? option.substring(matchIndex + searchKeyword.length) : '';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
      decoration: BoxDecoration(
        color: cardBackground,
        border: Border(
          left: BorderSide(width: 1, color: border),
          right: BorderSide(width: 1, color: border),
          bottom: BorderSide(width: 1, color: border),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(color: kPrimaryLight.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
            child: Icon(iconData, size: 16, color: kPrimaryDark),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: RichText(
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                style: const TextStyle(color: textPrimary, fontSize: 14, fontWeight: FontWeight.w400),
                children: [
                  TextSpan(text: before),
                  if (hasMatch)
                    TextSpan(
                      text: match,
                      style: const TextStyle(color: kPrimary, fontWeight: FontWeight.w700),
                    ),
                  TextSpan(text: after),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
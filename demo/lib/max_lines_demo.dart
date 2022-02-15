import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'text_card.dart';
import 'utils.dart';

class MaxlinesDemo extends StatelessWidget {
  final bool richText;

  MaxlinesDemo(this.richText);

  @override
  Widget build(BuildContext context) {
    const text =
        'This String will be automatically resized to fit on two lines.';
    return Row(
      children: <Widget>[
        Expanded(
          child: TextCard(
            title: 'Text',
            child: !richText
                ? Text(
                    text,
                    style: TextStyle(fontSize: 30),
                  )
                : Text.rich(
                    spanFromString(text),
                    style: TextStyle(fontSize: 30),
                  ),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: TextCard(
            title: 'AutoSizeText',
            child: !richText
                ? AutoSizeText(
                    text,
                    style: TextStyle(fontSize: 30),
                    maxLines: 2,
                  )
                : SelectableAutoSizeText.rich(
                    spanFromString(text),
                    style: TextStyle(fontSize: 30),
                    maxLines: 2,
                  ),
          ),
        ),
      ],
    );
  }
}

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'text_card.dart';
import 'utils.dart';

class MinFontSizeDemo extends StatelessWidget {
  final bool richText;

  MinFontSizeDemo(this.richText);

  @override
  Widget build(BuildContext context) {
    const text = 'This String\'s size will not be smaller than 20. It will be '
        'automatically resized to fit on 4 lines. Otherwise, the String will '
        'be ellipsized. Here is some random stuff, just to make sure it is '
        'long enough.';

    return Row(
      children: <Widget>[
        Expanded(
          child: TextCard(
            title: 'Text',
            child: !richText
                ? Text(
                    text,
                    style: TextStyle(fontSize: 30),
                    maxLines: 4,
                  )
                : Text.rich(
                    spanFromString(text),
                    style: TextStyle(fontSize: 30),
                    maxLines: 4,
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
                    minFontSize: 20,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 4,
                  )
                : AutoSizeText.rich(
                    spanFromString(text),
                    style: TextStyle(fontSize: 30),
                    minFontSize: 20,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 4,
                  ),
          ),
        ),
      ],
    );
  }
}

import 'dart:ui';

import 'package:auto_size_text/src/auto_size_builder/auto_size_builder.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SelectableAutoSizeText extends StatelessWidget {
  const SelectableAutoSizeText(
    String this.data, {
    Key? key,
    this.focusNode,
    this.style,
    this.overflow,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.textScaleFactor,
    this.showCursor = false,
    this.autofocus = false,
    this.toolbarOptions,
    this.minLines,
    this.maxLines,
    this.cursorWidth = 2.0,
    this.cursorHeight,
    this.cursorRadius,
    this.cursorColor,
    this.selectionHeightStyle = BoxHeightStyle.tight,
    this.selectionWidthStyle = BoxWidthStyle.tight,
    this.dragStartBehavior = DragStartBehavior.start,
    this.enableInteractiveSelection = true,
    this.selectionControls,
    this.onTap,
    this.scrollPhysics,
    this.textHeightBehavior,
    this.textWidthBasis,
    this.onSelectionChanged,
    this.wrapWords,
    this.overflowReplacement,
    this.overflowCallback,
    this.minFontSize,
    this.maxFontSize,
    this.stepGranularity,
    this.presetFontSizes,
    this.locale,
  })  : textSpan = null,
        super(key: key);

  const SelectableAutoSizeText.rich(
    TextSpan this.textSpan, {
    Key? key,
    this.focusNode,
    this.style,
    this.overflow,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.textScaleFactor,
    this.showCursor = false,
    this.autofocus = false,
    this.toolbarOptions,
    this.minLines,
    this.maxLines,
    this.cursorWidth = 2.0,
    this.cursorHeight,
    this.cursorRadius,
    this.cursorColor,
    this.selectionHeightStyle = BoxHeightStyle.tight,
    this.selectionWidthStyle = BoxWidthStyle.tight,
    this.dragStartBehavior = DragStartBehavior.start,
    this.enableInteractiveSelection = true,
    this.selectionControls,
    this.onTap,
    this.scrollPhysics,
    this.textHeightBehavior,
    this.textWidthBasis,
    this.onSelectionChanged,
    this.wrapWords,
    this.overflowReplacement,
    this.overflowCallback,
    this.minFontSize,
    this.maxFontSize,
    this.stepGranularity,
    this.presetFontSizes,
    this.locale,
  })  : data = null,
        super(key: key);

  /// The text to display.
  ///
  /// This will be null if a [textSpan] is provided instead.
  final String? data;

  /// The text to display as a [TextSpan].
  ///
  /// This will be null if [data] is provided instead.
  final TextSpan? textSpan;

  /// Defines the focus for this widget.
  ///
  /// Text is only selectable when widget is focused.
  ///
  /// The [focusNode] is a long-lived object that's typically managed by a
  /// [StatefulWidget] parent. See [FocusNode] for more information.
  ///
  /// To give the focus to this widget, provide a [focusNode] and then
  /// use the current [FocusScope] to request the focus:
  ///
  /// ```dart
  /// FocusScope.of(context).requestFocus(myFocusNode);
  /// ```
  ///
  /// This happens automatically when the widget is tapped.
  ///
  /// To be notified when the widget gains or loses the focus, add a listener
  /// to the [focusNode]:
  ///
  /// ```dart
  /// focusNode.addListener(() { print(myFocusNode.hasFocus); });
  /// ```
  ///
  /// If null, this widget will create its own [FocusNode] with
  /// [FocusNode.skipTraversal] parameter set to `true`, which causes the widget
  /// to be skipped over during focus traversal.
  final FocusNode? focusNode;

  /// The style to use for the text.
  ///
  /// If null, defaults [DefaultTextStyle] of context.
  final TextStyle? style;

  /// {@template auto_size_text.overflow}
  /// How visual overflow should be handled.
  ///
  /// Defaults to retrieving the value from the nearest [DefaultTextStyle] ancestor.
  /// If there is no ancestor, [TextOverflow.clip] is used.
  /// {@endtemplate}
  final TextOverflow? overflow;

  /// {@macro flutter.widgets.editableText.strutStyle}
  final StrutStyle? strutStyle;

  /// {@macro flutter.widgets.editableText.textAlign}
  final TextAlign? textAlign;

  /// {@macro flutter.widgets.editableText.textDirection}
  final TextDirection? textDirection;

  /// {@macro flutter.widgets.editableText.textScaleFactor}
  final double? textScaleFactor;

  /// {@macro flutter.widgets.editableText.autofocus}
  final bool autofocus;

  /// {@macro flutter.widgets.editableText.minLines}
  final int? minLines;

  /// {@macro flutter.widgets.editableText.maxLines}
  final int? maxLines;

  /// {@macro flutter.widgets.editableText.showCursor}
  final bool showCursor;

  /// {@macro flutter.widgets.editableText.cursorWidth}
  final double cursorWidth;

  /// {@macro flutter.widgets.editableText.cursorHeight}
  final double? cursorHeight;

  /// {@macro flutter.widgets.editableText.cursorRadius}
  final Radius? cursorRadius;

  /// The color to use when painting the cursor.
  ///
  /// Defaults to the theme's `cursorColor` when null.
  final Color? cursorColor;

  /// Controls how tall the selection highlight boxes are computed to be.
  ///
  /// See [ui.BoxHeightStyle] for details on available styles.
  final BoxHeightStyle selectionHeightStyle;

  /// Controls how wide the selection highlight boxes are computed to be.
  ///
  /// See [ui.BoxWidthStyle] for details on available styles.
  final BoxWidthStyle selectionWidthStyle;

  /// {@macro flutter.widgets.editableText.enableInteractiveSelection}
  final bool enableInteractiveSelection;

  /// {@macro flutter.widgets.editableText.selectionControls}
  final TextSelectionControls? selectionControls;

  /// {@macro flutter.widgets.scrollable.dragStartBehavior}
  final DragStartBehavior dragStartBehavior;

  /// Configuration of toolbar options.
  ///
  /// Paste and cut will be disabled regardless.
  ///
  /// If not set, select all and copy will be enabled by default.
  final ToolbarOptions? toolbarOptions;

  /// {@macro flutter.widgets.editableText.selectionEnabled}
  bool get selectionEnabled => enableInteractiveSelection;

  /// Called when the user taps on this selectable text.
  ///
  /// The selectable text builds a [GestureDetector] to handle input events like tap,
  /// to trigger focus requests, to move the caret, adjust the selection, etc.
  /// Handling some of those events by wrapping the selectable text with a competing
  /// GestureDetector is problematic.
  ///
  /// To unconditionally handle taps, without interfering with the selectable text's
  /// internal gesture detector, provide this callback.
  ///
  /// To be notified when the text field gains or loses the focus, provide a
  /// [focusNode] and add a listener to that.
  ///
  /// To listen to arbitrary pointer events without competing with the
  /// selectable text's internal gesture detector, use a [Listener].
  final GestureTapCallback? onTap;

  /// {@macro flutter.widgets.editableText.scrollPhysics}
  final ScrollPhysics? scrollPhysics;

  /// {@macro flutter.dart:ui.textHeightBehavior}
  final TextHeightBehavior? textHeightBehavior;

  /// {@macro flutter.painting.textPainter.textWidthBasis}
  final TextWidthBasis? textWidthBasis;

  /// {@macro flutter.widgets.editableText.onSelectionChanged}
  final SelectionChangedCallback? onSelectionChanged;

  /// {@template auto_size_text.wrapWords}
  /// Whether words which don't fit in one line should be wrapped.
  ///
  /// If false, the fontSize is lowered as far as possible until all words fit
  /// into a single line.
  /// {@endtemplate}
  final bool? wrapWords;

  /// {@template auto_size_text.overflowReplacement}
  /// If the text is overflowing and does not fit its bounds, this widget is
  /// displayed instead.
  /// {@endtemplate}
  final Widget? overflowReplacement;

  /// {@template auto_size_text.onOverflow}
  /// Called when the text overflows its container.
  /// {@endtemplate}
  final Function(bool overflow)? overflowCallback;

  /// {@template auto_size_text.minFontSize}
  /// The minimum text size constraint to be used when auto-sizing text.
  ///
  /// Is being ignored if [presetFontSizes] is set.
  /// {@endtemplate}
  final double? minFontSize;

  /// {@template auto_size_text.maxFontSize}
  /// The maximum text size constraint to be used when auto-sizing text.
  ///
  /// Is being ignored if [presetFontSizes] is set.
  /// {@endtemplate}
  final double? maxFontSize;

  /// {@template auto_size_text.stepGranularity}
  /// The step size in which the font size is being adapted to constraints.
  ///
  /// The Text scales uniformly in a range between [minFontSize] and
  /// [maxFontSize].
  /// Each increment occurs as per the step size set in stepGranularity.
  ///
  /// Most of the time you don't want a stepGranularity below 1.0.
  ///
  /// Is being ignored if [presetFontSizes] is set.
  /// {@endtemplate}
  final double? stepGranularity;

  /// {@template auto_size_text.presetFontSizes}
  /// Predefines all the possible font sizes.
  ///
  /// **Important:** PresetFontSizes have to be in descending order.
  /// {@endtemplate}
  final List<double>? presetFontSizes;

  /// {@template auto_size_text.locale}
  /// Used to select a font when the same Unicode character can
  /// be rendered differently, depending on the locale.
  ///
  /// It's rarely necessary to set this property. By default its value
  /// is inherited from the enclosing app with `Localizations.localeOf(context)`.
  ///
  /// See [RenderParagraph.locale] for more information.
  /// {@endtemplate}
  final Locale? locale;

  @override
  Widget build(BuildContext context) {
    final span = textSpan ?? TextSpan(text: data);
    return AutoSizeBuilder(
      text: span,
      style: style,
      builder: (context, scale, overflow) {
        overflowCallback?.call(overflow);
        return SelectableText.rich(
          span,
          style: style,
          strutStyle: strutStyle,
          textAlign: textAlign,
          textDirection: textDirection,
          textScaleFactor: scale,
          autofocus: autofocus,
          minLines: minLines,
          maxLines: maxLines,
          showCursor: showCursor,
          cursorWidth: cursorWidth,
          cursorHeight: cursorHeight,
          cursorRadius: cursorRadius,
          cursorColor: cursorColor,
          selectionHeightStyle: selectionHeightStyle,
          selectionWidthStyle: selectionWidthStyle,
          enableInteractiveSelection: enableInteractiveSelection,
          selectionControls: selectionControls,
          dragStartBehavior: dragStartBehavior,
          scrollPhysics: scrollPhysics,
          textHeightBehavior: textHeightBehavior,
          textWidthBasis: textWidthBasis,
          onSelectionChanged: onSelectionChanged,
          onTap: onTap,
        );
      },
      strutStyle: strutStyle,
      minFontSize: minFontSize,
      maxFontSize: maxFontSize,
      stepGranularity: stepGranularity,
      presetFontSizes: presetFontSizes,
      textAlign: textAlign,
      textDirection: textDirection,
      locale: locale,
      wrapWords: wrapWords,
      overflowReplacement: overflowReplacement,
      textScaleFactor: textScaleFactor,
      maxLines: maxLines,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
    );
  }
}

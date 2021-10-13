import 'package:flutter/material.dart';
import 'package:fluvie/resource/styles/dimens.dart';

class TextStyles {
  static const TextStyle header = TextStyle(
    fontSize: Dimens.textXLarge,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );

  static const TextStyle contentTitle = TextStyle(
    fontSize: Dimens.textNormal,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );

  static const TextStyle content = TextStyle(
    fontSize: Dimens.textNormal,
    fontWeight: FontWeight.normal,
    color: Colors.black,
  );
  
  static const TextStyle paragraph = TextStyle(
    fontSize: Dimens.textNormal,
    fontWeight: FontWeight.normal,
    color: Colors.black,
  );

  static const TextStyle caption = TextStyle(
    fontSize: Dimens.textSmall,
    fontWeight: FontWeight.normal,
    color: Colors.grey,
  );

  static const TextStyle sectionHeader = TextStyle(
    fontSize: Dimens.textSmall,
    fontWeight: FontWeight.w700,
    color: Colors.grey,
    fontStyle: FontStyle.italic,
  );
}

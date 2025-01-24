import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Masked {
  static MaskTextInputFormatter maskGowNumber = MaskTextInputFormatter(
      mask: '## # ### ##',
      filter: {"#": RegExp(r'[0-9A-Z]')},
      type: MaskAutoCompletionType.lazy);

  static MaskTextInputFormatter maskTechSeriya = MaskTextInputFormatter(
      mask: '###',
      filter: {"#": RegExp(r'[A-Z]')},
      type: MaskAutoCompletionType.lazy);

  static MaskTextInputFormatter maskTechNumber = MaskTextInputFormatter(
      mask: '#######',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  static MaskTextInputFormatter maskPolicySeriya = MaskTextInputFormatter(
      mask: '####',
      filter: {"#": RegExp(r'[A-Z]')},
      type: MaskAutoCompletionType.lazy);

  static MaskTextInputFormatter maskPolicyNumber = MaskTextInputFormatter(
      mask: '#######',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  static MaskTextInputFormatter maskBirthday = MaskTextInputFormatter(
      mask: '##.##.####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  static MaskTextInputFormatter maskPassportSeriya = MaskTextInputFormatter(
      mask: '##',
      filter: {"#": RegExp(r'[A-Z]')},
      type: MaskAutoCompletionType.lazy);

  static MaskTextInputFormatter maskPassportNumber = MaskTextInputFormatter(
      mask: '#######',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  static MaskTextInputFormatter maskPravaSeriya = MaskTextInputFormatter(
      mask: '##',
      filter: {"#": RegExp(r'[A-Z]')},
      type: MaskAutoCompletionType.lazy);

  static MaskTextInputFormatter maskPravaNomer = MaskTextInputFormatter(
      mask: '#######',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  static MaskTextInputFormatter maskInn = MaskTextInputFormatter(
      mask: '### ### ###',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);
  static MaskTextInputFormatter maskPinfl = MaskTextInputFormatter(
      mask: '# ## ## ## ### ## ##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  static MaskTextInputFormatter maskPhone = MaskTextInputFormatter(
      mask: '(##) ###-##-##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy,
      initialText: "0");

  static MaskTextInputFormatter maskText = MaskTextInputFormatter(
      mask: '+998 (##) ###-##-##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  static MaskTextInputFormatter maskSeryPolicy = MaskTextInputFormatter(
      mask: '####',
      filter: {"#": RegExp(r'[A-Z]')},
      type: MaskAutoCompletionType.lazy);

  static MaskTextInputFormatter maskCode = MaskTextInputFormatter(
      mask: '# # # # #',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  static const String hintGowNumber = "01 A 001 AA";
  static const String hintTechSeriya = "AAF";
  static const String hintPolicySery = "ABCD";
  static const String hintPravaSeriya = "AA";
  static const String hintPassportSeriya = "AA";
  static const String hintTechNumber = "0000000";
  static const String hintPassportNumber = "0000000";
  static const String hintPravaNomer = "0000000";
  static const String hintBirthday = "kk.oo.yyyy";
  static const String hintInn = "000 000 000";
  static const String hintPINFL = "0 00 00 00 000 00 00";
  static const String hintPolicyNumber = "0000000";
  static const String hintPhone = "(00) 000 - 00 - 00";
  static const String hintCode = "* * * * *";
}

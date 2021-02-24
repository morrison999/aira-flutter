import 'package:either_option/either_option.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class FormInputPhone extends FormInput<String> {
  FormInputPhone(String label, String value, {String hint = "", required = false})
      : super(label, value, hint: hint, required: required);

  @override
  List<TextInputFormatter> formatters() {
    return <TextInputFormatter>[LengthLimitingTextInputFormatter(12), FilteringTextInputFormatter.digitsOnly];
  }

  @override
  Either<String, bool> validate() {
    if (_required) {
      if (_value == null || _value.isBlank) return Left("Phone number required");
    }

    return Right(true);
  }
}
// ignore: must_be_immutable
class FormInputEmail extends FormInputString {
  FormInputEmail(String label, String value, {String hint = "Enter valid email", required = false})
      : super(label, value, hint: hint, required: required);

  @override
  Either<String, bool> validate() {
    var either = super.validate();
    if(either.isLeft)
      return either;

    if (_value.isEmail)
      return Right(true);
    else
      return Left("Please enter a valid email");
  }
}
// ignore: must_be_immutable
class FormInputString extends FormInput<String> {
  FormInputString(String label, String value, {String hint = "", required = false})
      : super(label, value, hint: hint, required: required);

  @override
  Either<String, bool> validate() {
    if (_required && (_value == null || _value.isBlank)) return Left("Input cannot be blank");
    return Right(true);
  }
}



// ignore: must_be_immutable
abstract class FormInput<T> extends StatelessWidget {
  T _value;
  final String _label;
  final String hint;

  bool _required = false;

  FormInput(this._label, this._value, {this.hint, required = false}) {
    _required = required;
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [

      TextField(
        onChanged: (t) {
          _value = t as T;
          _announce(t);
        },
        decoration: InputDecoration(hintText: hint, labelText: _label),
        inputFormatters: formatters(),
      )
    ]);
  }

  T getValue() {
    return _value;
  }

  T setValue(T value) {
    _value = value;
    return _value;
  }

  // Override and validate _value
  Either<String, bool> validate();

  /// override and provide necessary validations for subclass
  List<TextInputFormatter> formatters() {
    return [];
  }

  void _announce(value) {
    SemanticsService.announce(value, TextDirection.ltr);
  }
}

abstract class SelectableItem<T> {
  String getKey();

  T getValue();
}

// ignore: must_be_immutable
class FormInputSelectList<T> extends StatelessWidget {
  List<SelectableItem<T>> list;
  String label;
  SelectableItem<T> selected;
  DropdownButton<SelectableItem<T>> button;

  FormInputSelectList(this.label, this.list);

  @override
  Widget build(BuildContext context) {
    button = DropdownButton<SelectableItem<T>>(
        items: list.map((c) {
          return new DropdownMenuItem<SelectableItem<T>>(value: c, child: Text(c.getKey()));
        }).toList(),
        onChanged: (s) => selected = s);
    return button;
  }

  T getSelected() {
    return selected.getValue();
  }
}

import 'package:flutter/material.dart';
import 'package:truckmanagement_app/theme.dart';

class CheckboxFormField extends FormField<bool> {
  CheckboxFormField(
      {Widget title,
      FormFieldSetter<bool> onSaved,
      FormFieldValidator<bool> validator,
      bool initialValue = false,
      bool autovalidate = false})
      : super(
          onSaved: onSaved,
          validator: validator,
          initialValue: initialValue,
          autovalidate: autovalidate,
          builder: (FormFieldState<bool> state) {
            return CheckboxListTile(
              dense: state.hasError,
              title: title,
              activeColor: basicTheme().accentColor,
              checkColor: Colors.black,
              value: state.value,
              onChanged: state.didChange,
              subtitle: state.hasError
                  ? Builder(
                      builder: (BuildContext context) => Center(
                        child: Text(
                          state.errorText,
                          style: TextStyle(color: Theme.of(context).errorColor),
                        ),
                      ),
                    )
                  : null,
              controlAffinity: ListTileControlAffinity.leading,
            );
          },
        );
}

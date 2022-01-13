import 'package:flutter/material.dart';
import 'package:planik/presentation/common/dimen.dart';
import 'package:planik/presentation/common/extensions.dart';

class CreatePlanNameForm extends StatefulWidget {
  const CreatePlanNameForm({Key? key}) : super(key: key);

  @override
  _CreatePlanNameFormState createState() => _CreatePlanNameFormState();
}

class _CreatePlanNameFormState extends State<CreatePlanNameForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(context.strings.createPlanScreenSubtitle),
        const SizedBox(height: Insets.large),
        TextFormField(
          cursorColor: context.theme.colorScheme.onPrimary,
          style: TextStyle(color: context.theme.colorScheme.onPrimary),
          decoration: InputDecoration(
            filled: true,
            fillColor: context.palette.primaryDarkColor,
            border: const UnderlineInputBorder(),
            labelStyle: TextStyle(color: context.theme.colorScheme.onPrimary),
            hintStyle: TextStyle(color: context.theme.colorScheme.onPrimary),
            labelText: context.strings.createPlanScreenNameInputLabel,
            hintText: context.strings.createPlanScreenNameInputHint,
          ),
          autocorrect: false,
          onChanged: (value) {},
        ),
      ],
    );
  }
}

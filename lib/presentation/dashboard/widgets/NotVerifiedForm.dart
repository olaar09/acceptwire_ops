import 'package:acceptwire/utils/helpers/buttons.dart';
import 'package:acceptwire/utils/helpers/text.dart';
import 'package:acceptwire/utils/widgets/text_field.dart';
import 'package:flutter/material.dart';

class NotVerifiedForm extends StatelessWidget {
  final _emailTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
      child: Form(
        child: ListView(
          children: <Widget>[
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                boldText('Verify your identity'),
              ],
            ),
            SizedBox(height: 10),
            mTextField('Phone number',
                onChanged: (text) {},
                controller: _emailTextController,
                error: ''),
            SizedBox(height: 8.0),
            Row(
              children: [
                Expanded(
                  child: primaryButton('Create profile', vertical: 14,
                      onPressed: () async {
                    print('ff');
                  }),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

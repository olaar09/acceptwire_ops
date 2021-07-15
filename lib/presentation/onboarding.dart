import 'package:acceptwire/logic/auth_bloc/auth_bloc.dart';
import 'package:acceptwire/logic/auth_bloc/auth_states.dart';
import 'package:acceptwire/logic/meta_bloc/bloc.dart';
import 'package:acceptwire/utils/helpers/buttons.dart';
import 'package:acceptwire/utils/helpers/get_value.dart';
import 'package:acceptwire/utils/helpers/navigation.dart';
import 'package:acceptwire/utils/helpers/text.dart';
import 'package:acceptwire/utils/helpers/widget.dart';
import 'package:acceptwire/utils/widgets/error.dart';
import 'package:acceptwire/utils/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_detector/focus_detector.dart';

class OnBoarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    splashHighlightItem({text, imagePath}) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          iconsSize('$imagePath'),
          SizedBox(
            width: 15,
          ),
          Expanded(child: boldText('$text'))
        ],
      );
    }

    Widget displayContent() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              color: Vl.color(color: MColor.K_LIGHT_PLAIN),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        boldText('acceptwire',
                            size: 22,
                            fontWeight: FontWeight.w900,
                            color: Vl.color(color: MColor.K_PRIMARY_MAIN)),
                        splashHighlightItem(
                            imagePath: 'assets/images/ply.png',
                            text:
                                'Watch recorded class lectures unlimited times after class'),
                        splashHighlightItem(
                            imagePath: 'assets/images/connection.png',
                            text: 'Collaborate with classmates and teachers'),
                        splashHighlightItem(
                            imagePath: 'assets/images/reading.png',
                            text: 'Learn on your own terms & in your own time'),
                      ],
                    ),
                    height: 300,
                  ),
                ),
              ),
            ),
          ),
          Container(
              child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
            child: Row(children: [
              Expanded(
                  child: primaryButton('Continue',
                      fontSize: 18.0,
                      onPressed: () => navToPage(
                          context: context, route: '/login', data: null),
                      vertical: 12))
            ]),
          )),
          SizedBox(
            height: 30,
          )
        ],
      );
    }

    return Scaffold(
      backgroundColor: Vl.color(color: MColor.K_LIGHT_PLAIN),
      body: displayContent(),
    );
  }
}

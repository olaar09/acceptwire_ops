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
  splashHighlightItem({text, imagePath, title}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            iconsSize('$imagePath', size: 35),
          ],
        ),
        SizedBox(
          width: 15,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              boldText('$title'),
              Row(
                children: [
                  Expanded(
                    child: regularText('$text', size: 14),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget displayContent(context) {
    return ListView(
      children: [
        Container(
          color: Vl.color(color: MColor.K_LIGHT_PLAIN),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: 100),
                    boldText('acceptwire',
                        size: 22,
                        fontWeight: FontWeight.w900,
                        color: Vl.color(color: MColor.K_PRIMARY_MAIN)),
                    SizedBox(height: 40),
                    splashHighlightItem(
                        imagePath: 'assets/images/thunderbolt.png',
                        title: 'Receive instant payments',
                        text:
                            'Receive card payments & transfers in seconds, guaranteed. Eliminate bank alert delays & frauds'),
                    SizedBox(height: 20),
                    splashHighlightItem(
                        imagePath: 'assets/images/bill.png',
                        title: 'Send digital receipts',
                        text:
                            'Send professional looking digital receipts to customers & showcase more of your products after purchase'),
                    SizedBox(height: 20),
                    splashHighlightItem(
                        imagePath: 'assets/images/onlineshopping.png',
                        title: 'Automatic  re-targeting',
                        text:
                            'Automatically send marketing contents to customers to showcase new products and offer deals based on purchase history'),
                  ],
                ),
                // height: 440,
              ),
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
                margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 18.0, vertical: 8.0),
                  child: Row(children: [
                    Expanded(
                        child: primaryButton('Continue',
                            fontSize: 18.0,
                            onPressed: () => navToPage(
                                context: context, route: '/login', data: null),
                            vertical: 12))
                  ]),
                )),
          ],
        ),
        SizedBox(
          height: 30,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Vl.color(color: MColor.K_LIGHT_PLAIN),
      body: displayContent(context),
    );
  }
}

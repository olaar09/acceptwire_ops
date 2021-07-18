import 'package:acceptwire/utils/helpers/text.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class AccountNumbers extends StatelessWidget {
  const AccountNumbers({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //  SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              regularText('Account numbers'),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Icon(Icons.arrow_circle_down_rounded, size: 18),
                  SizedBox(width: 3),
                  regularText('transactions reflecting in less than 30 seconds',
                      size: 12),
                ],
              ),
            ],
          ),
        ),
        Container(
          height: 90,
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              buildAccountItem(
                  bankName: 'Access Bank', accountNumber: '0999883838'),
              SizedBox(width: 20),
              buildAccountItem(
                  bankName: 'Wema Bank', accountNumber: '88388383838'),
            ],
          ),
        ),
      ],
    );
  }

  Container buildAccountItem({required bankName, required accountNumber}) {
    return Container(
      child: DottedBorder(
        color: Colors.grey,
        borderType: BorderType.RRect,
        radius: Radius.circular(12),
        padding: EdgeInsets.all(6),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                child: Text('acc'),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  regularText('$bankName', size: 16),
                  boldText('$accountNumber'),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

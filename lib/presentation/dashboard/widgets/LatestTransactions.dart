import 'package:acceptwire/utils/helpers/get_value.dart';
import 'package:acceptwire/utils/helpers/helpers.dart';
import 'package:acceptwire/utils/helpers/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LatestTransactions extends StatelessWidget {
  const LatestTransactions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 10,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: regularText('Latest transactions'),
            ),
            Expanded(
              child: CustomScrollView(
                physics: BouncingScrollPhysics(),
                slivers: [
                  CupertinoSliverRefreshControl(
                    onRefresh: () async {
                      await Future.delayed(Duration(seconds: 20));
                    },
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return Container(
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(8.0),
                              height: 80,
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    child: Text('bnk'),
                                    radius: 16,
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            boldText(formatMoney(10050)),
                                            regularText('Access bank',
                                                size: 14),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      6.0, 0, 0, 0),
                                              child: regularText('10/08/2021',
                                                  size: 14),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  height: 30,
                                                  child: IconButton(
                                                      onPressed: () {
                                                        print('send receipts');
                                                      },
                                                      icon: Icon(
                                                          Icons
                                                              .receipt_long_sharp,
                                                          color: Vl.color(
                                                              color: MColor
                                                                  .K_SECONDARY_TEXT))),
                                                ),
                                                Container(
                                                  height: 30,
                                                  child: IconButton(
                                                      onPressed: () {
                                                        print(
                                                            'view transaction');
                                                      },
                                                      icon: Icon(
                                                        Icons
                                                            .more_horiz_rounded,
                                                        color: Vl.color(
                                                            color: MColor
                                                                .K_SECONDARY_TEXT),
                                                      )),
                                                )
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider()
                          ],
                        ),
                      );
                    }, childCount: 100),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

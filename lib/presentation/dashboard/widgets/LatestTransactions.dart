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
                        color: Colors.white,
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(8.0),
                              height: 60,
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    child: Text('bnk'),
                                    radius: 16,
                                  ),
                                  SizedBox(width: 10),
                                  Text('Transaction item'),
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

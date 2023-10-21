import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:share_plus/share_plus.dart';

import '../../controllers/main/transaction_controller.dart';
import '../../models/main/transaction_model.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({Key? key}) : super(key: key);

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  final _controller = TransactionController.to;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.refreshPagingController();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 231, 231, 231),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        centerTitle: true,
        title: Text('Transaction', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(
                  left: screenSize.width * .05,
                ),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: screenSize.height * .005),
                      child: Text('Enter inventory',
                          style: TextStyle(color: Colors.black54)),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: screenSize.height * .005),
                      child: Text('150', style: TextStyle(fontSize: 27)),
                    ),
                    Container(
                        margin: EdgeInsets.symmetric(
                            vertical: screenSize.height * .005),
                        child: Container(
                          padding: EdgeInsets.all(screenSize.height * .005),
                          decoration: BoxDecoration(
                              color: Colors.greenAccent.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(2)),
                          child: Row(children: [
                            Text('   Enters   ',
                                style: TextStyle(color: Colors.green)),
                            Icon(
                              Icons.arrow_upward_rounded,
                              color: Colors.green,
                              size: screenSize.height * .015,
                            )
                          ]),
                        )),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: screenSize.width * .005,
                    vertical: screenSize.height * .018),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: screenSize.height * .005),
                      child: Text('Withdrawal of inventory ',
                          style: TextStyle(color: Colors.black54)),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: screenSize.height * .005),
                      child: Text('170', style: TextStyle(fontSize: 27)),
                    ),
                    Container(
                        margin: EdgeInsets.symmetric(
                            vertical: screenSize.height * .005),
                        child: Container(
                          padding: EdgeInsets.all(screenSize.height * .005),
                          decoration: BoxDecoration(
                              color: Colors.redAccent.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(3)),
                          child: Row(children: [
                            Text('   Withdrawals   ',
                                style: TextStyle(color: Colors.red)),
                            Icon(
                              Icons.arrow_downward,
                              color: Colors.red,
                              size: screenSize.height * .015,
                            )
                          ]),
                        )),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 10),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: screenSize.height * .005),
                      child: Text('Transfer invtory',
                          style: TextStyle(color: Colors.black54)),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: screenSize.height * .005),
                      child: Text('4', style: TextStyle(fontSize: 27)),
                    ),
                    Container(
                        margin: EdgeInsets.symmetric(
                            vertical: screenSize.height * .005),
                        child: Container(
                          padding: EdgeInsets.all(screenSize.height * .005),
                          decoration: BoxDecoration(
                              color: Colors.greenAccent.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(2)),
                          child: Row(children: [
                            Text('   Trnsfer   ',
                                style: TextStyle(color: Colors.green)),
                            Icon(
                              Icons.arrow_upward_rounded,
                              color: Colors.green,
                              size: screenSize.height * .015,
                            )
                          ]),
                        )),
                  ],
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(
                left: screenSize.width * .06, bottom: screenSize.height * .015),
            alignment: Alignment.topLeft,
            child: Text('All Transactions', style: TextStyle(fontSize: 22)),
          ),
          Expanded(
            child: PagedListView(
              pagingController: _controller.pagingController,
              builderDelegate: PagedChildBuilderDelegate<TransactionDataModel>(
                itemBuilder: (context, item, index) => Padding(
                    padding: EdgeInsets.all(7),
                    child: TransactionItem(
                        id: item.id.toString(),
                        date: item.date.toString(),
                        title: item.title.toString(),
                        description: item.description.toString(),
                        imageUrl: item.image)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TransactionItem extends StatelessWidget {
  final String id;
  final String title;
  final String date;
  final String description;
  final String imageUrl;

  const TransactionItem({
    required this.id,
    required this.title,
    required this.date,
    required this.description,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(
                        vertical: screenSize.height * .012,
                        horizontal: screenSize.width * .05),
                    child: Text(title,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500)),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                        vertical: screenSize.height * .012,
                        horizontal: screenSize.width * .025),
                    child: Text('Date : 12/10 ',
                        style: TextStyle(
                            color: Colors.black38,
                            fontSize: 12,
                            fontWeight: FontWeight.w500)),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: screenSize.width * .028,
                        vertical: screenSize.height * .012),
                    child: Text('time :  11:30 ',
                        style: TextStyle(
                            color: Colors.black26,
                            fontSize: 12,
                            fontWeight: FontWeight.w500)),
                  ),
                ],
              ),
              Container(
                margin:
                    EdgeInsets.symmetric(horizontal: screenSize.width * .05),
                child: Text('Transaction ID : 10005',
                    style: TextStyle(color: Colors.black54, fontSize: 13)),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: screenSize.width * .05,
                    vertical: screenSize.width * .03),
                child: Text('Quantity withdrawn : 20',
                    style: TextStyle(color: Colors.black54, fontSize: 13)),
              ),
              Container(
                margin:
                    EdgeInsets.symmetric(horizontal: screenSize.width * .05),
                child: Row(
                  children: [
                    Icon(Icons.share),
                    TextButton(
                      onPressed: () {
                        Share.share(
                          '\n\nname item :  \n\n Transactions Id :  \n\n '
                          'Date : '
                          '  time : }',
                        );
                      },
                      child: Text('Share',
                          style: TextStyle(color: Colors.black, fontSize: 16)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.all(15),
            child: Icon(Icons.arrow_downward, color: Colors.red),
          )
        ],
      ),
    );
  }
}

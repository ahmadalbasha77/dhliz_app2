import 'package:flutter/material.dart';
import 'view_details_transfer_screen.dart';

class TransferInventoryScreen extends StatelessWidget {
  const TransferInventoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 231, 231, 231),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          title:
              Text('Transfer Inventory', style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.white,
        ),
        body: Container(
            child: ListView.builder(
                itemCount: 2,
                itemBuilder: (context, index) => Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                child: Text('wh',
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500)),
                              ),
                              Row(
                                children: [
                                  Container(
                                      margin: EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 20),
                                      child: Text(
                                        'weight :25 ',
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 13),
                                      )),
                                  Container(
                                      child: Text(
                                    'stock Id :1111',
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 13),
                                  )),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 20),
                                    child: TextButton(
                                      onPressed: () {
                                        // Navigator.of(context)
                                        //     .push(MaterialPageRoute(
                                        //   builder: (context) =>
                                        //       ViewDetailsTransferScreen(
                                        //           id: value
                                        //               .listTransfer[index]
                                        //               .id),
                                        // ));
                                      },
                                      child: Text('view detils',
                                          style:
                                              TextStyle(color: Colors.black)),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Container(
                            child: CircleAvatar(
                              radius: 40,
                              backgroundImage: AssetImage(''),
                            ),
                            width: 110,
                          ),
                        ])))));
  }
}

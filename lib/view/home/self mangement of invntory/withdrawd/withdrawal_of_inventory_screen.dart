import 'package:flutter/material.dart';

class WithdrawalOfInventoryScreen extends StatefulWidget {
  const WithdrawalOfInventoryScreen({Key? key}) : super(key: key);

  @override
  State<WithdrawalOfInventoryScreen> createState() =>
      _WithdrawalOfInventoryScreenState();
}

class _WithdrawalOfInventoryScreenState
    extends State<WithdrawalOfInventoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 231, 231, 231),
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          centerTitle: true,
          title: const Text('Withdrawal of invntory',
              style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.white,
        ),
        body: ListView.builder(
            itemCount: 2,
            itemBuilder: (context, index) => Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
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
                            margin: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            child: Text('wh1',
                                style: const TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.w500)),
                          ),
                          Row(
                            children: [
                              Container(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 20),
                                  child: Text(
                                    'weight: 20',
                                    style: const TextStyle(
                                        color: Colors.black54, fontSize: 12),
                                  )),
                              Text(
                                'stock Id: 1002',
                                style: const TextStyle(
                                    color: Colors.black54, fontSize: 12),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 20),
                                child: TextButton(
                                  onPressed: () {
                                    // Navigator.of(context)
                                    //     .push(MaterialPageRoute(
                                    //   builder: (context) =>
                                    //       ViewDetailsWithdrawScreen(
                                    //           id: value
                                    //               .Listitem2[index].id),
                                    // ));
                                  },
                                  child: const Text('Withdraw stock',
                                      style: TextStyle(color: Colors.black)),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 110,
                        child: CircleAvatar(
                          radius: 40,
                          backgroundImage:
                              AssetImage('image/dehliz/1633444786084.jpeg'),
                        ),
                      ),
                    ]))));
  }
}

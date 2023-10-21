import 'package:dhliz_app/controllers/home/withdrawal_controller.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../models/home/withdrawal_model.dart';

class WithdrawalOfInventoryScreen extends StatefulWidget {
  const WithdrawalOfInventoryScreen({Key? key}) : super(key: key);

  @override
  State<WithdrawalOfInventoryScreen> createState() =>
      _WithdrawalOfInventoryScreenState();
}

class _WithdrawalOfInventoryScreenState
    extends State<WithdrawalOfInventoryScreen> {
  final _controller = WithdrawalController.to;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.refreshPagingController();
  }

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
        body: PagedListView(
          pagingController: _controller.pagingController,
          builderDelegate: PagedChildBuilderDelegate<WithdrawalDataModel>(
            itemBuilder: (context, item, index) => WithdrawalItem(
              title: item.title.toString(),
              description: item.description.toString(),
              imageUrl: item.image.toString(),
              id: item.id.toString(),
            ),
          ),
        ));
  }
}

class WithdrawalItem extends StatelessWidget {
  final String id;
  final String title;
  final String description;
  final String imageUrl;

  const WithdrawalItem({
    super.key,
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.white),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Text(title,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w500)),
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
                    'stock Id: 10002',
                    style: const TextStyle(color: Colors.black54, fontSize: 12),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: TextButton(
                      onPressed: () {},
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
              backgroundImage: NetworkImage(imageUrl),
            ),
          ),
        ]));
  }
}

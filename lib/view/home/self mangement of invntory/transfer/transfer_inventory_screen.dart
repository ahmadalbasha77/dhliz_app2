import 'package:dhliz_app/controllers/home/transfer_controller.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../../models/home/transfer_model.dart';
import 'view_details_transfer_screen.dart';

class TransferInventoryScreen extends StatefulWidget {
  const TransferInventoryScreen({Key? key}) : super(key: key);

  @override
  State<TransferInventoryScreen> createState() =>
      _TransferInventoryScreenState();
}

class _TransferInventoryScreenState extends State<TransferInventoryScreen> {
  final _controller = TransferController.to;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.refreshPagingController();
  }

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
        body: PagedListView(
          pagingController: _controller.pagingController,
          builderDelegate: PagedChildBuilderDelegate<TransferDataModel>(
              itemBuilder: (context, item, index) => TransferItem(
                    title: item.title.toString(),
                    description: item.description.toString(),
                    imageUrl: item.image.toString(),
                    id: item.id.toString(),
                  )),
        ));
  }
}

class TransferItem extends StatelessWidget {
  final String id;
  final String title;
  final String description;
  final String imageUrl;

  const TransferItem({
    super.key,
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.white),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Text(title,
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
              ),
              Row(
                children: [
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                      child: Text(
                        'weight :25 ',
                        style: TextStyle(color: Colors.black54, fontSize: 13),
                      )),
                  Container(
                      child: Text(
                    'stock Id :1111',
                    style: TextStyle(color: Colors.black54, fontSize: 13),
                  )),
                ],
              ),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              ViewDetailsTransferScreen(id: id),
                        ));
                      },
                      child: Text('view detils',
                          style: TextStyle(color: Colors.black)),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            child: CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(imageUrl),
            ),
            width: 110,
          ),
        ]));
  }
}

import 'package:dhliz_app/controllers/main/notification_controller.dart';
import 'package:dhliz_app/models/main/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final _controller = NotificationController.to;

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
          centerTitle: true,
          elevation: 0,
          backgroundColor: Color.fromARGB(255, 231, 231, 231),
          title: Text(
            'Notifications',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          actions: [
            Icon(
              Icons.delete,
              color: Colors.black,
            )
          ]),
      body: Column(
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 35, top: 20),
                child:
                    Text(' you have ', style: TextStyle(color: Colors.black54)),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Text(' 2 Notifications '),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Text(' Today', style: TextStyle(color: Colors.black54)),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            alignment: Alignment.topLeft,
            child: Text('Today',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500)),
          ),
          Expanded(
            child: PagedListView(
              pagingController: _controller.pagingController,
              builderDelegate: PagedChildBuilderDelegate<NotificationDataModel>(
                itemBuilder: (context, item, index) => Padding(
                    padding: EdgeInsets.all(7),
                    child: NotificationsItem(
                        title: item.title.toString(),
                        description: item.description.toString(),
                        imageUrl: item.image.toString())),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NotificationsItem extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;

  const NotificationsItem({
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      margin: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
      padding: EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        title: Text(title, style: TextStyle(fontSize: 13)),
        subtitle: Text(description),
        leading:
            CircleAvatar(backgroundImage: NetworkImage(imageUrl), radius: 50),
        trailing: Icon(Icons.delete_forever_rounded),
      ),
    );
  }
}

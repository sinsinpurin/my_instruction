import 'package:flutter/material.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  var item = ["ヘルスケア", "スポーツ"];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(30),
      child: ListView.builder(
        itemCount: item.length,
        itemBuilder: (context, index) {
          return _ListItem(item[index]);
        },
      ),
    );
  }

  Widget _ListItem(String title) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return const AlertDialog(
                title: Text('onTap!!!'),
              );
            });
      },
    );
  }
}

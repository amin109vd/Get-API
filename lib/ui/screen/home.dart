import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/controller/controller.dart';
import 'package:flutter_application_1/ui/screen/comment.dart';
import 'package:flutter_application_1/ui/screen/search.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/ui/utils/utilss.dart';

import '../../data/model/postmodel.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  ///return a card title and body
  static Widget card(context, title, body, id) {
    return Card(
      elevation: 0.8,
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                const Spacer(),
                Text(
                  id,
                  style: const TextStyle(color: Colors.deepPurple),
                )
              ],
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.headline6,
              maxLines: 1,
            ),
            10.toHeight,
            Text(
              body,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ///find controller
    Get.put(ControllerLogic());
    final logic = Get.find<ControllerLogic>();
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: Search());
              },
              icon: const Icon(Icons.search))
        ],
        backgroundColor: Colors.deepPurple.shade300,
        title: const Text("Post List"),
      ),
      body: FutureBuilder(
          future: logic.getServer(),
          builder: (context, snapshot) {
            return snapshot.hasData
                ? ListView.builder(
                    itemBuilder: (context, index) {
                      ///get post model
                      Postmodel postModel = snapshot.data![index];
                      return GestureDetector(
                          onTap: () {
                            Get.to(const Comment(), arguments: postModel.id);
                          },
                          child: card(context, postModel.title, postModel.body,
                              postModel.id.toString()));
                    },
                    itemCount: snapshot.data!.length,
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  );
          }),
    );
  }
}

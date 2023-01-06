import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/utils/utilss.dart';
import 'package:get/get.dart';

import '../../data/controller/controller.dart';
import '../../data/model/commentmodel.dart';

class Comment extends StatelessWidget {
  const Comment({Key? key}) : super(key: key);

  Widget card(
      {required String name,
      required String email,
      required String body,
      required BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.all(3),
      child: Card(
        elevation: 0.7,
        color: Colors.grey.shade300,
        child: Container(
          padding: const EdgeInsets.all(5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              RichText(
                  maxLines: 1,
                  text: TextSpan(
                      text: "name : ",
                      style: const TextStyle(
                          color: Colors.deepPurple,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                          text: name,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 18),
                        ),
                      ])),
              10.toHeight,
              RichText(
                  text: TextSpan(
                      text: "email : ",
                      style: const TextStyle(
                          color: Colors.deepPurple,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                      children: [
                    TextSpan(
                      text: email,
                      style: const TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ])),
              10.toHeight,
              Text(body,
                  style: const TextStyle(color: Colors.black, fontSize: 15)),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var data = Get.arguments;
    final logic = Get.find<ControllerLogic>();
    return Scaffold(
        backgroundColor: Colors.deepPurple.shade100,
        appBar: AppBar(
          backgroundColor: Colors.deepPurple.shade300,
          title: Text(data.toString()),
        ),
        body: FutureBuilder(
          builder: (context, snapshot) => snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    Commentmodel commentModel = snapshot.data![index];
                    return card(
                        context: context,
                        name: commentModel.name.toString(),
                        email: commentModel.email.toString(),
                        body: commentModel.body.toString());
                  })
              : const Center(
                  child: CircularProgressIndicator(),
                ),
          future: logic.getCommentServer(data),
        ));
  }
}

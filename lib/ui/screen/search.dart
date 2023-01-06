import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/screen/comment.dart';
import 'package:flutter_application_1/ui/screen/home.dart';
import 'package:get/get.dart';
import '../../data/controller/controller.dart';
import '../../data/model/postmodel.dart';

class Search extends SearchDelegate {
  ///find controller
  final logic = Get.find<ControllerLogic>();

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
        future: logic.getServer(query: query),
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
                        child: HomePage.card(context, postModel.title,
                            postModel.body, postModel.id.toString()));
                  },
                  itemCount: snapshot.data!.length,
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return query.isNotEmpty
        ? FutureBuilder(
            future: logic.getServer(query: query),
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? ListView.builder(
                      itemBuilder: (context, index) {
                        ///get post model
                        Postmodel postModel = snapshot.data![index];
                        return GestureDetector(
                            onTap: () {
                              query = postModel.title.toString();
                            },
                            child: ListTile(
                              title: Text(postModel.title.toString()),
                              trailing: Text(postModel.id.toString()),
                            ));
                      },
                      itemCount: snapshot.data!.length,
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    );
            })
        : const Center(
            child: Text("Search post"),
          );
  }
}

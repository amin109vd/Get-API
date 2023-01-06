import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../model/commentmodel.dart';
import '../model/postmodel.dart';

class ControllerLogic extends GetxController {
  ///Get API post
  Future<List<Postmodel>> getServer({String? query}) async {
    List<Postmodel> postlist = [];
    try {
      var responds =
          await Dio().get("https://jsonplaceholder.typicode.com/posts");
      for (var res in responds.data) {
        Postmodel postmodel = Postmodel.fromJson(res);
        postlist.add(postmodel);
        if (query != null) {
          if (query.isNum) {
            postlist = postlist
                .where((element) => element.id.toString().contains(query))
                .toList();
          } else {
            postlist = postlist
                .where((element) =>
                    element.title!.toLowerCase().contains(query.toLowerCase()))
                .toList();
          }
        }
      }
    } catch (e) {
      log("$e");
    }
    return postlist;
  }

  ///Get API comment
  Future<List<Commentmodel>> getCommentServer(id) async {
    List<Commentmodel> commentList = [];
    try {
      var responds = await Dio()
          .get("https://jsonplaceholder.typicode.com/comments?postId=$id");
      for (var res in responds.data) {
        commentList.add(Commentmodel.fromJson(res));
      }
    } catch (e) {
      log("$e");
    }
    return commentList;
  }
}

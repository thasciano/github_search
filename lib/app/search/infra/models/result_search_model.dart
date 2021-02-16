import 'dart:convert';

import 'package:github_search/app/search/domain/entities/result_search.dart';

class ResultSearchModel extends ResultSearch {
  final String image;
  final String name;
  final String nickname;
  final String url;

  ResultSearchModel({this.image, this.name, this.nickname, this.url});

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'name': name,
      'nickname': nickname,
      'url': url,
    };
  }

  factory ResultSearchModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ResultSearchModel(
      image: map['image'],
      name: map['name'],
      nickname: map['nickname'],
      url: map['url'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ResultSearchModel.fromJson(String source) =>
      ResultSearchModel.fromMap(json.decode(source));
}

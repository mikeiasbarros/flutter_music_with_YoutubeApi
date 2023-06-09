import 'dart:convert';

//import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


import 'class_video.dart';

const Url_api = 'https://www.googleapis.com/youtube/v3/';
var Api_key = 'AIzaSyCtE5-RDIx3CscpGvVX8RT7RJd8rRoXzgg';

class Api {
  Future<List<YoutubeVideo>> Pesquisa(String pesquisa) async {
    String url =
        '${Url_api}search?part=snippet&key=$Api_key''&maxResults=1''&q=$pesquisa';
    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      Map<String, dynamic> dados = json.decode(response.body);
      List<YoutubeVideo> videos = dados['items'].map<YoutubeVideo>(
          (map){
            return YoutubeVideo.fromJson(map);

          }
      ).toList();


      return videos;
    } else {
      // Caso ocorra um erro, você pode lançar uma exceção ou retornar um valor padrão
      throw Exception('Erro na requisição da API: ${response.body}');
    }
  }
}
class YoutubeVideo {
  late String? title;
  late String? description;
  late String ?thumbnailsUrl;
  late String? videoId;
  //late String videoDuration;
  late String? channelTitle;
  YoutubeVideo( {this.videoId,this.title, this.description, this.thumbnailsUrl, this.channelTitle});
  factory YoutubeVideo.fromJson(Map<String, dynamic> json){
    return YoutubeVideo(
      videoId: json['id']['videoId'],
      title: json['snippet']['title'],
      description: json['snippet']['description'],
      thumbnailsUrl: json['snippet']['thumbnails']['high']['url'],
      channelTitle: json["snippet"]['channelTitle'],
    );
  }

}

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

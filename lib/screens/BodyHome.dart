import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:yumusic/consts.dart';
import 'package:yumusic/widgets/CardContainer.dart';
import '../API/models/class_api.dart';
import 'OfflineMusic/music_user.dart';
import 'VideoScreen.dart';

class BodyHome extends StatefulWidget {
  const BodyHome({Key? key}) : super(key: key);

  @override
  State<BodyHome> createState() => _BodyHomeState();
}

class _BodyHomeState extends State<BodyHome> {
  @override
  Widget build(BuildContext context) {
    Api api = Api();
    Size size = MediaQuery.of(context).size;
    final kNotificationBar = MediaQuery.of(context).padding.top;
    return Scaffold(
        drawer: Drawer(
          //    width: .5,
          child: Container(
            padding: const EdgeInsets.only(left: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  //container usando apenas para criar um espaçamento superior, sem mudar o layout
                  height: kNotificationBar,
                  color: Colors.transparent,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.account_circle,
                    size: 50,
                  ),
                  title: Text(
                    "Mikeias Barros",
                    style: GoogleFonts.poppins()
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  subtitle: Text('Programador',
                      style: GoogleFonts.openSans().copyWith()),
                ),
                const Divider(),
                Text(
                  "Navegação",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(),
                )
              ],
            ),
          ),
        ),
        appBar: customAppBar(),
        body: FutureBuilder<List<YoutubeVideo>>(
            future: api.Pesquisa(' musicas'),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const Center(
                    child: CircularProgressIndicator(
                      color: kPrimaryColor,
                    ),
                  );
                case ConnectionState.none:
                  return const Center(
                    child: Text("Nenhum resultado encontrado"),
                  );
                case ConnectionState.active:
                  return const Center(
                    child: Text('Ativo'),
                  );
                case ConnectionState.done:
                  if (snapshot.hasData) {
                    List<YoutubeVideo> videos = snapshot.data!;
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: videos.length,
                            itemBuilder: (context, index) {
                              YoutubeVideo video = videos[index];
                              return GestureDetector(
                                onTap: () {
                                  //reproduzirAudio();
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                        print('${video.videoId}');
                                        print('${video.channelTitle}');
                                        print('${video.thumbnailsUrl}');
                                        print('${video.title}');
                                    return MusicScreen(

                                      videoId: '${video.videoId}',
                                      channelTitle: '${video.channelTitle}',
                                      image: '${video.thumbnailsUrl}',
                                      title: '${video.title}',
                                    );
                                  }));
                                },
                                child: ListTile(
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  leading:
                                      Image.network('${video.thumbnailsUrl}'),
                                  title: Text('${video.title}',
                                      maxLines: 2,
                                      style: GoogleFonts.poppins().copyWith(
                                          fontWeight: FontWeight.w500)),
                                  subtitle: Text('${video.channelTitle}',
                                      style: GoogleFonts.openSans().copyWith()),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Text("Erro desconhecido. Verifique sua conexão!");
                  }
              }
            }));
  }

  AppBar customAppBar() {
    return AppBar(
      title: Text(
        'BigSong',
        style: GoogleFonts.poppins(fontSize: 25),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        ),
        IconButton(
            onPressed: () {}, icon: const Icon(Icons.account_circle_outlined)),
      ],
    );
  }
}
//
// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';
//
// const Url_api = 'https://www.googleapis.com/youtube/v3/';
// var Api_key = 'AIzaSyCtE5-RDIx3CscpGvVX8RT7RJd8rRoXzgg';
//
// class MusicScreen extends StatefulWidget {
//   final String title, channelTitle, image, videoId;
//
//   const MusicScreen({
//     Key? key,
//     required this.title,
//     required this.channelTitle,
//     required this.image,
//     required this.videoId,
//   }) : super(key: key);
//
//   @override
//   _MusicScreenState createState() => _MusicScreenState();
// }
//
// class _MusicScreenState extends State<MusicScreen> {
//   late AudioPlayer _audioPlayer;
//
//   @override
//   void initState() {
//     super.initState();
//     _audioPlayer = AudioPlayer();
//     reproduzirAudio();
//   }
//
//   @override
//   void dispose() {
//     _audioPlayer.stop();
//     super.dispose();
//   }
//
//   Future<String> extrairAudioDoVideo() async {
//     String url =
//         '${Url_api}videos?part=contentDetails&id=${widget.videoId}&key=$Api_key';
//     http.Response response = await http.get(Uri.parse(url));
//
//     if (response.statusCode == 200) {
//       Map<String, dynamic> dados = json.decode(response.body);
//       String videoDuration = dados['items'][0]['contentDetails']['duration'];
//       // Extrair a duração do vídeo e ajustar para obter apenas o áudio
//
//       // Aqui você pode usar uma biblioteca de manipulação de duração do vídeo, como a 'flutter_duration' ou 'youtube_explode'
//       // para converter a duração do vídeo em apenas o áudio. Por exemplo, remover 'PT' e 'S' se for no formato PT0H0M0S (exemplo: PT5M30S).
//
//       // Suponha que a duração seja convertida corretamente para '5M30S'
//       String audioUrl = 'https://www.youtube.com/watch?v=${widget.videoId}';
//       return audioUrl;
//     } else {
//       throw Exception('Erro na requisição da API: ${response.body}');
//     }
//   }
//
//   Future<void> reproduzirAudio() async {
//     try {
//       String audioUrl = await extrairAudioDoVideo();
//       int result = await _audioPlayer.play(audioUrl, isLocal: false);
//
//       if (result != 1) {
//         throw Exception('Falha ao reproduzir o áudio');
//       }
//     } catch (e) {
//       print('Erro ao reproduzir o áudio: $e');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Container(
//               height: 200,
//               width: size.width * .8,
//               margin: const EdgeInsets.symmetric(horizontal: 20),
//               decoration: const BoxDecoration(),
//               child: Image.network(
//                 widget.image,
//               ),
//             ),
//             const SizedBox(height: 20),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20.0),
//               child: Text(
//                 widget.title,
//                 maxLines: 1,
//                 style: GoogleFonts.poppins().copyWith(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20.0),
//               child: Text(
//                 widget.channelTitle,
//                 maxLines: 1,
//                 style: GoogleFonts.openSans(),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
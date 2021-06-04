import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:dakotawebsite/datamodels/episode_item_model.dart';

class Api {
  static const String _apiEndpoint =
      'https://simentan.ponorogo.go.id/api/public/api/galleryNoAuth';

  Future<dynamic> getEpisodes() async {
    var response = await http.get(Uri.parse(_apiEndpoint));

    if (response.statusCode == 200) {
      var episodes = (json.decode(response.body) as List)
          .map((episode) => EpisodeItemModel.fromJson(episode))
          .toList();
      return episodes;
    }
    // http://apidinper.reboeng.com/api/galleryNoAuth

    // something wrong happened
    return 'Could not fetch the episodes at this time';
  }
}

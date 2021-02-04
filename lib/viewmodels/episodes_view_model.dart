import 'package:flutter/material.dart';
import 'package:dakotawebsite/datamodels/episode_item_model.dart';
import 'package:dakotawebsite/locator.dart';
import 'package:dakotawebsite/services/api.dart';

class EpisodesViewModel extends ChangeNotifier {
  final _api = locator<Api>();

  List<EpisodeItemModel> _episodes;
  List<EpisodeItemModel> get episodes => _episodes;

  Future getEpisodes() async {
    var episodeResults = await _api.getEpisodes();

    if (episodeResults is String) {
      // show error
    } else {
      _episodes = episodeResults;
    }

    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'package:provider_architecture/viewmodel_provider.dart';
import 'package:dakotawebsite/datamodels/season_details_model.dart';
import 'package:dakotawebsite/viewmodels/episodes_view_model.dart';
import 'package:dakotawebsite/widgets/episodes_list/episodes_list.dart';
import 'package:dakotawebsite/widgets/season_details/season_details.dart';

class EpisodesView extends StatelessWidget {
  const EpisodesView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<EpisodesViewModel>.withConsumer(
      viewModel: EpisodesViewModel(),
      onModelReady: (model) => model.getEpisodes(),
      builder: (context, model, child) => SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          SizedBox(
            height: 100,
          ),
          SeasonDetails(
            details: SeasonDetailsModel(
              title: 'Terbaru',
              description:
                  'Ini adalah galeri kegiatan terbaru dari aplikasi simentan.',
            ),
          ),
          SizedBox(
            height: 50,
          ),
          model.episodes == null
              ? CircularProgressIndicator()
              : EpisodesList(episodes: model.episodes),
        ],
      )),
    );
  }
}

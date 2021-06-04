import 'package:flutter/material.dart';
import 'package:dakotawebsite/datamodels/season_details_model.dart';
import 'package:dakotawebsite/viewmodels/episodes_view_model.dart';
import 'package:dakotawebsite/widgets/episodes_list/episodes_list.dart';
import 'package:dakotawebsite/widgets/season_details/season_details.dart';
import 'package:provider/provider.dart';

class EpisodesView extends StatefulWidget {
  const EpisodesView({Key key}) : super(key: key);

  @override
  State<EpisodesView> createState() => _EpisodesViewState();
}

class _EpisodesViewState extends State<EpisodesView> {

  @override
  void initState() {
    super.initState();
    EpisodesViewModel episodesViewModel = Provider.of<EpisodesViewModel>(context, listen: false);
    episodesViewModel.getEpisodes();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EpisodesViewModel>(
      builder:(context, model, _) => SingleChildScrollView(
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

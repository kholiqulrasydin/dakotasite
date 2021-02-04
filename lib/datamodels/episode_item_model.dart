class EpisodeItemModel {
  final String title;
  final String duration;
  final String imageUrl;

  EpisodeItemModel({
    this.title,
    this.duration,
    this.imageUrl,
  });

  EpisodeItemModel.fromJson(Map<String, dynamic> map)
      : title = map['title'],
        duration = map['uploader'],
        imageUrl = map['image_url'];
}

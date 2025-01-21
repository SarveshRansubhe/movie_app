class GetMoviesListParams {
  int page;
  String language = 'en-US';
  bool includeAdult;
  bool includeVideo;
  GetMoviesListParamsSortBy sortBy;

  GetMoviesListParams({
    required this.page,
    this.language = 'en-US',
    this.includeAdult = false,
    this.includeVideo = false,
    this.sortBy = GetMoviesListParamsSortBy.popularityDesc,
  });

  GetMoviesListParams.fromJson(Map<String, dynamic> json)
      : page = json['page'],
        language = json['language'],
        includeAdult = json['include_adult'],
        includeVideo = json['include_video'],
        sortBy = GetMoviesListParamsSortBy.values
            .firstWhere((e) => e.toString() == json['sort_by']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    data['language'] = language;
    data['include_adult'] = includeAdult;
    data['include_video'] = includeVideo;
    data['sort_by'] = sortBy.toString().split('.').last;
    return data;
  }
}

enum GetMoviesListParamsSortBy {
  popularityDesc,
  popularityAsc,
  releaseDateDesc,
  releaseDateAsc,
  revenueDesc,
  revenueAsc,
  primaryReleaseDateDesc,
  primaryReleaseDateAsc,
  originalTitleDesc,
  originalTitleAsc,
  voteAverageDesc,
  voteAverageAsc,
  voteCountDesc,
  voteCountAsc
}

class SearchEntity {
  SearchEntity({
    this.customerAccountUid,
    this.uid,
    this.keyword,
    this.searchCount,
  });

  final String? customerAccountUid;
  final String? uid;
  final String? keyword;
  final int? searchCount;

  SearchEntity copyWith({
    String? customerAccountUid,
    String? uid,
    String? keyword,
    int? searchCount,
  }) =>
      SearchEntity(
        customerAccountUid: customerAccountUid ?? this.customerAccountUid,
        uid: uid ?? this.uid,
        keyword: keyword ?? this.keyword,
        searchCount: searchCount ?? this.searchCount,
      );
}

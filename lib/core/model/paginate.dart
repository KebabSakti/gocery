// To parse this JSON data, do
//
//     final paginate = paginateFromJson(jsonString);

import 'dart:convert';

Paginate paginateFromJson(String str) => Paginate.fromJson(json.decode(str));

String paginateToJson(Paginate data) => json.encode(data.toJson());

class Paginate<T> {
  Paginate({
    this.data,
    this.links,
    this.meta,
  });

  final T? data;
  final Links? links;
  final Meta? meta;

  Paginate copyWith({
    T? data,
    Links? links,
    Meta? meta,
  }) =>
      Paginate(
        links: links ?? this.links,
        meta: meta ?? this.meta,
      );

  factory Paginate.fromJson(Map<String, dynamic> json) => Paginate(
        data: json["data"],
        links: Links.fromJson(json["links"]),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data,
        "links": links?.toJson(),
        "meta": meta?.toJson(),
      };
}

class Links {
  Links({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  final String? first;
  final String? last;
  final String? prev;
  final String? next;

  Links copyWith({
    String? first,
    String? last,
    String? prev,
    String? next,
  }) =>
      Links(
        first: first ?? this.first,
        last: last ?? this.last,
        prev: prev ?? this.prev,
        next: next ?? this.next,
      );

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        first: json["first"],
        last: json["last"],
        prev: json["prev"],
        next: json["next"],
      );

  Map<String, dynamic> toJson() => {
        "first": first,
        "last": last,
        "prev": prev,
        "next": next,
      };
}

class Meta {
  Meta({
    this.currentPage,
    this.from,
    this.lastPage,
    this.path,
    this.perPage,
    this.to,
    this.total,
  });

  final int? currentPage;
  final int? from;
  final int? lastPage;
  final String? path;
  final int? perPage;
  final int? to;
  final int? total;

  Meta copyWith({
    int? currentPage,
    int? from,
    int? lastPage,
    String? path,
    int? perPage,
    int? to,
    int? total,
  }) =>
      Meta(
        currentPage: currentPage ?? this.currentPage,
        from: from ?? this.from,
        lastPage: lastPage ?? this.lastPage,
        path: path ?? this.path,
        perPage: perPage ?? this.perPage,
        to: to ?? this.to,
        total: total ?? this.total,
      );

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        currentPage: json["current_page"],
        from: json["from"],
        lastPage: json["last_page"],
        path: json["path"],
        perPage: json["per_page"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "from": from,
        "last_page": lastPage,
        "path": path,
        "per_page": perPage,
        "to": to,
        "total": total,
      };
}

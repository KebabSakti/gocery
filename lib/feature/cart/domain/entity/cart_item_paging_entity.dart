import 'package:gocery/core/entity/link_entity.dart';
import 'package:gocery/core/entity/meta_entity.dart';
import 'package:gocery/feature/cart/domain/entity/cart_item_entity.dart';

class CartItemPagingEntity {
  CartItemPagingEntity({
    this.data,
    this.links,
    this.meta,
  });

  final List<CartItemEntity>? data;
  final LinkEntity? links;
  final MetaEntity? meta;

  CartItemPagingEntity copyWith({
    List<CartItemEntity>? data,
    LinkEntity? links,
    MetaEntity? meta,
  }) =>
      CartItemPagingEntity(
        data: data ?? this.data,
        links: links ?? this.links,
        meta: meta ?? this.meta,
      );
}

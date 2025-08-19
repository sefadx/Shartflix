import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pagination_model.g.dart';

@JsonSerializable()
class Pagination extends Equatable {
  final int totalCount;
  final int perPage;
  final int maxPage;
  final int currentPage;

  const Pagination({
    required this.totalCount,
    required this.perPage,
    required this.maxPage,
    required this.currentPage,
  });

  static const Pagination initial = Pagination(
    totalCount: 0,
    perPage: 0,
    maxPage: 0,
    currentPage: 1,
  );

  factory Pagination.fromJson(Map<String, dynamic> json) => _$PaginationFromJson(json);
  Map<String, dynamic> toJson() => _$PaginationToJson(this);

  @override
  List<Object?> get props => [totalCount, perPage, maxPage, currentPage];
}

part of 'database_bloc.dart';

@immutable
sealed class DatabaseState {}

final class DatabaseInitial extends DatabaseState {}

final class DataFetched extends DatabaseState {
  final List<Brew>? brews;
  DataFetched({required this.brews});
}

final class DataFetching extends DatabaseState {}

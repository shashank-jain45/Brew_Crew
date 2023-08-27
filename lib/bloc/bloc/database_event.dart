part of 'database_bloc.dart';

@immutable
sealed class DatabaseEvent {}

class GetData extends DatabaseEvent {
  final List<Brew>? brews;
  GetData({this.brews});
}

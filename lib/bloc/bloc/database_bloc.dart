import 'package:bloc/bloc.dart';
import 'package:brew_crew/model/brew.dart';
import 'package:brew_crew/services/database.dart';
import 'package:meta/meta.dart';

part 'database_event.dart';
part 'database_state.dart';

class DatabaseBloc extends Bloc<DatabaseEvent, DatabaseState> {
  DatabaseBloc() : super(DataFetched(brews: const [])) {
    DataBaseService().brew.listen((event) {
      add(GetData(brews: event));
    });
    DataBaseService().brew.listen((event) {
      add(GetData(brews: event));
    });

    on<GetData>(
      (event, emit) {
        if (event.brews != null) {
          emit(
            DataFetched(brews: event.brews),
          );
        }
      },
    );
  }
}

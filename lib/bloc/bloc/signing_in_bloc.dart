import 'package:bloc/bloc.dart';
import 'package:brew_crew/model/user.dart';
import 'package:meta/meta.dart';

import '../../services/authentication.dart';

part 'signing_in_event.dart';
part 'signing_in_state.dart';

class SigningInBloc extends Bloc<SigningInEvent, SigningInState> {
  SigningInBloc() : super(SigningInInitial()) {
    // register bloc
    on<Register>(
      (event, emit) async {
        final AuthService auth = AuthService();
        emit(Loading());
        UserModel? user = await auth.registerWithEmailAndPassword(
            event.email, event.password);
        if (user == null) {
          emit(
            ErrorRegisteringIn(),
          );
        } else {
          emit(SignedIn(userId: user.id));
        }
      },
    );
    //sign in bloc
    on<SignIn>(
      (event, emit) async {
        final AuthService auth = AuthService();
        emit(Loading());
        UserModel? user =
            await auth.signInWithEmailAndPassword(event.email, event.password);

        if (user == null) {
          emit(ErrorSigningIn());
        } else {
          emit(SignedIn(userId: user.id));
        }
      },
    );
    //Sign out bloc
    on<SignOut>((event, emit) async {
      final AuthService auth = AuthService();
      emit(
        Loading(),
      );
      dynamic result = await auth.signOut();
      if (result == null) {
        emit(
          NotSignedIn(),
        );
      }
    });
//loading bloc
    on<Fetching>(
      (event, emit) => emit(
        Loading(),
      ),
    );
  }
}

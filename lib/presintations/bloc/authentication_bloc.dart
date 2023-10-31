import 'package:bloc/bloc.dart';
import 'package:favourite_places/data/authentication_remote_data_source.dart';
import 'package:meta/meta.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRemoteDsImp remoteDs;

  AuthenticationBloc(this.remoteDs) : super(UnAuthentication()) {
    on<AuthenticationEvent>((event, emit) async {
      try {
        if (event is SignUpEvent) {
          emit(AuthenticationLodingState());
          await remoteDs.signUp(event.email, event.password);
          emit(Authentication());
        } else if (event is SignInEvent) {
          emit(AuthenticationLodingState());
          await remoteDs.signIn(event.email, event.password);
          emit(Authentication());
        } else if (event is SignOutEvent) {
          emit(AuthenticationLodingState());
          await remoteDs.signOut();
          emit(UnAuthentication());
        } else if (event is IsSignedInEvent) {
          emit(AuthenticationLodingState());
          bool isSignedIn= remoteDs.isSignedIn();
          emit(isSignedIn?Authentication():UnAuthentication());
        }
      } catch (e) {
        emit(AuthenticationErrorState(errorMessage: e.toString()));
      }
    });
  }
}

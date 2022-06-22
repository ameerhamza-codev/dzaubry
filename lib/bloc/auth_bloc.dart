import 'package:bloc/bloc.dart';
import 'package:dzaubry_newspaper/bloc/auth_event.dart';
import 'package:dzaubry_newspaper/bloc/auth_state.dart';
import 'package:dzaubry_newspaper/services/auth/auth_provider.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(AuthProvider provider) : super(const AuthStateLoading()) {

    //initialize
    on<AuthEventInitialize>((event, emit) async{
      await provider.initialize();

      final user = provider.currentUser;
      if(user==null) {
        emit(const AuthStateLoggedOut());
      } else {
        emit(AuthStateLoggedIn(user));
      }
    });

    //login
    on<AuthEventLogin>((event, emit) async{
      emit (const AuthStateLoading());
      final email = event.email;
      final password = event.password;
      try {
        final user = await provider.logIn(email: email, password: password);
        emit(AuthStateLoggedIn(user));
      } on Exception catch (e) {
        emit(AuthStateLoginFailure(e));
      }
    });

    //logout
    on<AuthEventLogout>((event, emit) async{
      emit (const AuthStateLoading());

      try {
        await provider.logOut();
        emit(AuthStateLoggedOut());
      } on Exception catch (e) {
        emit(AuthStateLogoutFailure(e));
      }
    });
  }
}
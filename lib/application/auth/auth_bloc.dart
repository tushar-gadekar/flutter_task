import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investor_app/infrastructure/auth/repository/auth_repositry.dart';

part 'auth_state.dart';
part 'auth_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepositry _authRepo;

  AuthBloc(this._authRepo) : super(AuthInitialState()) {
    on<CheckSessionEvent>(_onCheckSession);
    on<LoginEvent>(_onLogin);
    on<LogoutEvent>(_onLogout);
  }

  Future<void> _onCheckSession(CheckSessionEvent event, Emitter<AuthState> emit) async {
    final loggedIn = await _authRepo.isLoggedIn();
    if (loggedIn) {
      final email = await _authRepo.getUserEmail();
      emit(AuthenticatedState(email));
    } else {
      emit(UnAuthenticatedState());
    }
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    final success = await _authRepo.login(event.email, event.password);
    if (success) {
      emit(AuthenticatedState(event.email));
    } else {
      emit(AuthErrorState('Invalid email or password'));
    }
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    await _authRepo.logout();
    emit(UnAuthenticatedState());
  }
}
import 'package:console/app_exporter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState>
    with GlobalEventBusCommunication<AuthState> {
  final AuthRepo repo;
  AuthModel? _auth;

  AuthCubit(this.repo) : super(AuthInitialState());

  AuthModel? get auth => _auth;

  /// Picks up the session saved by a previous login, before the router decides
  /// whether to show the login
  Future<void> restore() async {
    _auth = await repo.restore();
  }

  void login({required String access, required String secret}) async {
    emit(AuthLoggingInState());
    try {
      _auth = await repo.login(access: access, secret: secret);
      await repo.save(_auth!);
      emit(AuthLoggedInOkState());
    } catch (e) {
      _auth = null;
      final exc = ExceptionConverter.parse(e);
      emit(AuthLoggingInErrorState(exc.intlMessage));
    }
  }

  void logout() {
    _auth = null;
    repo.clear();
    emit(AuthLogoutOkState());
  }

  void reset() {
    _auth = null;
    repo.clear();
    emit(AuthInitialState());
  }
}

abstract class AuthState {}

final class AuthInitialState extends AuthState {}

final class AuthLoggingInState extends AuthState {}

final class AuthLoggedInOkState extends AuthState {}

final class AuthLoggingInErrorState extends AuthState {
  final String message;

  AuthLoggingInErrorState(this.message);
}

final class AuthLogoutOkState extends AuthState {}

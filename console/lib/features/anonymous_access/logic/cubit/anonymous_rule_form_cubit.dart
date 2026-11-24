import 'package:console/app_exporter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// State of the add-rule drawer. It lives while the drawer is open, so loading
/// and errors show inside the form
class AnonymousRuleFormCubit extends Cubit<AnonymousRuleFormState>
    with GlobalEventBusCommunication<AnonymousRuleFormState> {
  final AnonymousAccessRepo _repo;
  final AuthCubit _auth;

  AnonymousRuleFormCubit(this._repo, this._auth)
    : super(const AnonymousRuleFormInitialState());

  Future<void> create({
    required String bucket,
    required AnonymousRuleModel rule,
  }) async {
    emit(const AnonymousRuleFormProcessInProgressState());
    try {
      await _repo.createRule(
        bucket: bucket,
        rule: rule,
        token: _auth.auth?.accessToken,
      );
      emit(AnonymousRuleFormProcessingOKState(prefix: rule.prefix));
    } catch (e) {
      final exception = ExceptionConverter.parse(e);
      emit(
        AnonymousRuleFormProcessingErrorState(
          exception,
          fieldErrors: switch (exception.data) {
            List<ValidationError> errors
                when exception.type == GlobalExceptionType.validation =>
              errors.asFailedValidations(),
            _ => const {},
          },
        ),
      );
    }
  }
}

/// Field names of the form, equal to the `fieldName`s the API returns
abstract class AnonymousRuleFormField {
  static const String prefix = 'prefix';
  static const String access = 'access';
}

abstract class AnonymousRuleFormState {
  const AnonymousRuleFormState();
}

final class AnonymousRuleFormInitialState extends AnonymousRuleFormState {
  const AnonymousRuleFormInitialState();
}

//------------------------- PROCESSING -------------------------\
final class AnonymousRuleFormProcessInProgressState
    extends AnonymousRuleFormState {
  const AnonymousRuleFormProcessInProgressState();
}

final class AnonymousRuleFormProcessingOKState extends AnonymousRuleFormState {
  final String prefix;

  const AnonymousRuleFormProcessingOKState({required this.prefix});
}

final class AnonymousRuleFormProcessingErrorState
    extends AnonymousRuleFormState {
  final GlobalException exception;

  /// Errors per field; if empty, the error belongs to the whole form
  final Map<String, String> fieldErrors;

  const AnonymousRuleFormProcessingErrorState(
    this.exception, {
    this.fieldErrors = const {},
  });
}

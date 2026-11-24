import 'package:console/app_exporter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Link to share an object: the service generates it with the chosen expiry
class ShareLinkCubit extends Cubit<ShareLinkState>
    with GlobalEventBusCommunication<ShareLinkState> {
  final BrowserRepo _repo;
  final AuthCubit _auth;

  ShareLinkCubit(this._repo, this._auth) : super(const ShareLinkInitialState());

  Future<void> generate({
    required String bucket,
    required String key,
    required ShareLinkExpiration expiration,
  }) async {
    emit(ShareLinkSigningState(expiration: expiration));
    try {
      final link = await _repo.presign(
        bucket: bucket,
        key: key,
        expiresIn: expiration.duration,
        token: _auth.auth?.accessToken,
      );
      // if another expiry was chosen meanwhile, this link is stale
      if (state.expiration != expiration) return;
      emit(ShareLinkSignedOkState(expiration: expiration, link: link));
    } catch (e) {
      if (state.expiration != expiration) return;
      emit(
        ShareLinkSigningErrorState(
          ExceptionConverter.parse(e),
          expiration: expiration,
        ),
      );
    }
  }
}

abstract class ShareLinkState {
  final ShareLinkExpiration expiration;

  const ShareLinkState({this.expiration = ShareLinkExpiration.day});
}

final class ShareLinkInitialState extends ShareLinkState {
  const ShareLinkInitialState();
}

//------------------------- LOADING -------------------------\\
final class ShareLinkSigningState extends ShareLinkState {
  const ShareLinkSigningState({super.expiration});
}

final class ShareLinkSignedOkState extends ShareLinkState {
  final SharedLinkModel link;

  const ShareLinkSignedOkState({required this.link, super.expiration});
}

final class ShareLinkSigningErrorState extends ShareLinkState {
  final GlobalException exception;

  const ShareLinkSigningErrorState(this.exception, {super.expiration});
}

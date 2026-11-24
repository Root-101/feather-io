import 'package:console/app_exporter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Target folder being picked in the move dialog: the bucket, the open folder
/// and its subfolders
class MoveTargetCubit extends Cubit<MoveTargetState>
    with GlobalEventBusCommunication<MoveTargetState> {
  final BrowserRepo _repo;
  final AuthCubit _auth;

  MoveTargetCubit(this._repo, this._auth)
    : super(const MoveTargetInitialState());

  /// Opens [prefix] of [bucket] and lists its subfolders
  Future<void> open({required String bucket, required String prefix}) async {
    emit(
      MoveTargetSearchingState(
        bucket: bucket,
        prefix: prefix,
        folders: bucket == state.bucket && prefix == state.prefix
            ? state.folders
            : const [],
      ),
    );
    try {
      final listing = await _repo.listObjects(
        token: _auth.auth?.accessToken,
        bucket: bucket,
        prefix: prefix,
        delimiter: '/',
        maxKeys: 1000,
      );
      // if another folder was opened meanwhile, this response is stale
      if (state.bucket != bucket || state.prefix != prefix) return;
      emit(
        MoveTargetSearchOkState(
          bucket: bucket,
          prefix: prefix,
          folders: listing.commonPrefixes,
        ),
      );
    } catch (e) {
      if (state.bucket != bucket || state.prefix != prefix) return;
      emit(
        MoveTargetSearchErrorState(
          ExceptionConverter.parse(e),
          bucket: bucket,
          prefix: prefix,
        ),
      );
    }
  }
}

abstract class MoveTargetState {
  final String? bucket;

  /// Open folder as a prefix (`books/2026/`); empty is the root
  final String prefix;

  /// Subfolders of [prefix], as full prefixes
  final List<String> folders;

  const MoveTargetState({
    this.bucket,
    this.prefix = '',
    this.folders = const [],
  });
}

final class MoveTargetInitialState extends MoveTargetState {
  const MoveTargetInitialState();
}

//------------------------- LOADING -------------------------\\
final class MoveTargetSearchingState extends MoveTargetState {
  const MoveTargetSearchingState({super.bucket, super.prefix, super.folders});
}

final class MoveTargetSearchOkState extends MoveTargetState {
  const MoveTargetSearchOkState({super.bucket, super.prefix, super.folders});
}

final class MoveTargetSearchErrorState extends MoveTargetState {
  final GlobalException exception;

  const MoveTargetSearchErrorState(
    this.exception, {
    super.bucket,
    super.prefix,
  });
}

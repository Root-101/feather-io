import 'dart:convert';

import 'package:console/app_exporter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Access keys of the *Access keys* section: list, search and the row actions
/// (enable/disable, regenerate the secret, delete)
class AccessKeysCubit extends Cubit<AccessKeysState>
    with GlobalEventBusCommunication<AccessKeysState> {
  final AccessKeysRepo _repo;
  final AuthCubit _auth;

  AccessKeysCubit(this._repo, this._auth)
    : super(const AccessKeysInitialState()) {
    // Deleting a bucket deletes the keys' grants on it (in the service): the
    // list reloads so no key keeps showing it
    onBus<BucketChangedEvent>((event) {
      if (event.change != BucketChange.deleted || !state.data.loaded) return;
      // A deleted bucket can't stay selected in the filter
      final filter = state.data.filter;
      if (filter.buckets.contains(event.bucketName)) {
        applyFilter(
          filter.copyWith(
            buckets: {...filter.buckets}..remove(event.bucketName),
          ),
        );
      }
      final granted = state.data.keys.any(
        (key) => key.grants.any((grant) => grant.bucket == event.bucketName),
      );
      if (granted) load();
    });
  }

  Future<void> load() async {
    emit(AccessKeysSearchingState(data: state.data));
    try {
      final list = await _repo.listKeys(token: _auth.auth?.accessToken);
      emit(AccessKeysSearchOkState(data: state.data.withList(list)));
    } catch (e) {
      emit(
        AccessKeysSearchErrorState(
          ExceptionConverter.parse(e),
          data: state.data,
        ),
      );
    }
  }

  /// Filters by name or id, over the keys already loaded
  void search(String query) {
    emit(AccessKeysSearchOkState(data: state.data.withQuery(query)));
  }

  /// Filters by status, level and bucket, over the keys already loaded
  void applyFilter(AccessKeyFilter filter) {
    emit(AccessKeysSearchOkState(data: state.data.withFilter(filter)));
  }

  Future<void> setEnabled(AccessKeyModel key, {required bool enabled}) async {
    await _process(
      enabled ? AccessKeyAction.enabled : AccessKeyAction.disabled,
      () => _repo.updateKey(
        id: key.id,
        draft: AccessKeyDraft.of(key, enabled: enabled),
        token: _auth.auth?.accessToken,
      ),
    );
  }

  /// The OK state carries the key with its new secret, to show it once
  Future<void> regenerateSecret(AccessKeyModel key) async {
    await _process(
      AccessKeyAction.secretRegenerated,
      () => _repo.regenerateSecret(id: key.id, token: _auth.auth?.accessToken),
    );
  }

  Future<void> delete(AccessKeyModel key) async {
    await _process(AccessKeyAction.deleted, () async {
      await _repo.deleteKey(id: key.id, token: _auth.auth?.accessToken);
      return key;
    });
  }

  /// Hands the browser a CSV with the key's id and secret, like the one AWS
  /// gives when creating a key
  void saveCredentials(AccessKeyModel key) {
    final csv =
        'Access key ID,Secret access key\n${key.id},${key.secret ?? ''}\n';
    FileSaver.save(utf8.encode(csv), '${key.name}_credentials.csv');
  }

  Future<void> _process(
    AccessKeyAction action,
    Future<AccessKeyModel> Function() run,
  ) async {
    emit(AccessKeysUpdatingState(data: state.data));
    try {
      final key = await run();
      emit(AccessKeysUpdatedOkState(action, key, data: state.data));
    } catch (e) {
      emit(
        AccessKeysUpdatingErrorState(
          ExceptionConverter.parse(e).intlMessage,
          data: state.data,
        ),
      );
      return;
    }
    await load();
  }
}

/// What a row action did, so the view can confirm it
enum AccessKeyAction { enabled, disabled, secretRegenerated, deleted }

/// The loaded keys, the search and the filters. [visibleKeys] is filled on
/// every change
class AccessKeyData {
  final String? rootAccessKeyId;
  final List<AccessKeyModel> keys;
  final String query;
  final AccessKeyFilter filter;
  final List<AccessKeyModel> visibleKeys;

  const AccessKeyData._({
    required this.rootAccessKeyId,
    required this.keys,
    required this.query,
    required this.filter,
    required this.visibleKeys,
  });

  const AccessKeyData.empty()
    : this._(
        rootAccessKeyId: null,
        keys: const [],
        query: '',
        filter: AccessKeyFilter.none,
        visibleKeys: const [],
      );

  factory AccessKeyData._filtered({
    required String? rootAccessKeyId,
    required List<AccessKeyModel> keys,
    required String query,
    required AccessKeyFilter filter,
  }) {
    final needle = query.trim().toLowerCase();
    return AccessKeyData._(
      rootAccessKeyId: rootAccessKeyId,
      keys: keys,
      query: query,
      filter: filter,
      visibleKeys: keys
          .where(
            (k) =>
                (needle.isEmpty ||
                    k.name.toLowerCase().contains(needle) ||
                    k.id.toLowerCase().contains(needle)) &&
                filter.matches(k),
          )
          .toList(),
    );
  }

  bool get loaded => rootAccessKeyId != null;

  AccessKeyData withList(AccessKeyListModel list) => AccessKeyData._filtered(
    rootAccessKeyId: list.rootAccessKeyId,
    keys: list.keys,
    query: query,
    filter: filter,
  );

  AccessKeyData withQuery(String query) => AccessKeyData._filtered(
    rootAccessKeyId: rootAccessKeyId,
    keys: keys,
    query: query,
    filter: filter,
  );

  AccessKeyData withFilter(AccessKeyFilter filter) => AccessKeyData._filtered(
    rootAccessKeyId: rootAccessKeyId,
    keys: keys,
    query: query,
    filter: filter,
  );
}

abstract class AccessKeysState {
  final AccessKeyData data;

  const AccessKeysState({this.data = const AccessKeyData.empty()});
}

final class AccessKeysInitialState extends AccessKeysState {
  const AccessKeysInitialState();
}

//------------------------- LOADING -------------------------\
final class AccessKeysSearchingState extends AccessKeysState {
  const AccessKeysSearchingState({required super.data});
}

final class AccessKeysSearchOkState extends AccessKeysState {
  const AccessKeysSearchOkState({required super.data});
}

final class AccessKeysSearchErrorState extends AccessKeysState {
  final GlobalException exception;

  const AccessKeysSearchErrorState(this.exception, {required super.data});
}

//------------------------- PROCESSING -------------------------\
final class AccessKeysUpdatingState extends AccessKeysState {
  const AccessKeysUpdatingState({required super.data});
}

final class AccessKeysUpdatedOkState extends AccessKeysState {
  final AccessKeyAction action;

  /// The key acted on; after [AccessKeyAction.secretRegenerated], with its secret
  final AccessKeyModel key;

  const AccessKeysUpdatedOkState(this.action, this.key, {required super.data});
}

final class AccessKeysUpdatingErrorState extends AccessKeysState {
  final String message;

  const AccessKeysUpdatingErrorState(this.message, {required super.data});
}

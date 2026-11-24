enum TransferStatus {
  queued,
  running,
  done,
  failed,
  cancelled;

  /// Queued or running
  bool get isActive => this == queued || this == running;
}

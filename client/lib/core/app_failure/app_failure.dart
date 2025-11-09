class AppFailure {
  final String msg;
  AppFailure({required this.msg});

  @override
  String toString() {
    return 'AppFailure: ($msg)';
  }
}

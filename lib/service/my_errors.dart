class MyException implements Exception {
  final String message;

  MyException({required this.message});

  @override
  String toString() {
    return message;
  }

}
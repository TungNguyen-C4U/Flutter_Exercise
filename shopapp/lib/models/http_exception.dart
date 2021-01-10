class HttpException implements Exception {
  final String message;
  HttpException(this.message);
  @override
  String toString() {
    return message;
    // return super.toString(); // Instance of HttpException
  }
}

///Now can triiger by ourExcep.toString() | print(ourExcep)

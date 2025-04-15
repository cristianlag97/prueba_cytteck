enum GeneralError { notFound, unknownError, invalidInput, databaseError }

class CustomError implements Exception {
  final GeneralError error;
  final String message;

  CustomError(this.error, this.message);

  @override
  String toString() {
    return 'CustomError: $message';
  }
}

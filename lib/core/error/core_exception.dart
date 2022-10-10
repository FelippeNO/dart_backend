class CoreException implements Exception {
  CoreException(StackTrace stackTrace, label, dynamic exception) {
    print(stackTrace);
    print(label);
    print(exception);
  }
}

class JsonParsingException extends CoreException {
  JsonParsingException(StackTrace stackTrace, String label, exception) : super(stackTrace, label, exception);
}

class GetBadRequisitionException extends CoreException {
  GetBadRequisitionException(StackTrace stackTrace, String label, exception) : super(stackTrace, label, exception);
}

class PostBadRequisitionException extends CoreException {
  PostBadRequisitionException(StackTrace stackTrace, String label, exception) : super(stackTrace, label, exception);
}

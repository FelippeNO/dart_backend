class CoreException implements Exception {
  CoreException(StackTrace stackTrace, label, dynamic exception) {
    print(stackTrace);
    print(label);
    print(exception);
  }
}

class RequisitionException implements Exception {
  final String label;
  final int statusCode;

  RequisitionException(this.label, this.statusCode);
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

class RequisitionsHandlers {
  static final RequisitionException unauthorizedException = RequisitionException("Unauthorized Access", 401);
}

import 'core_exception.dart';

class EmptyPrimaryKeyException extends CoreException {
  EmptyPrimaryKeyException(StackTrace stackTrace, label, exception) : super(stackTrace, label, exception);
}

class EmptyTableNameException extends CoreException {
  EmptyTableNameException(StackTrace stackTrace, label, exception) : super(stackTrace, label, exception);
}

class EntityDoNotContainInsertionAttributeException extends CoreException {
  EntityDoNotContainInsertionAttributeException(StackTrace stackTrace, label, exception)
      : super(stackTrace, label, exception);
}

class InsertionHasMoreAttributesThanEntityException extends CoreException {
  InsertionHasMoreAttributesThanEntityException(StackTrace stackTrace, label, exception)
      : super(stackTrace, label, exception);
}

class EntityDoNotContainPrimaryKeyNameException extends CoreException {
  EntityDoNotContainPrimaryKeyNameException(StackTrace stackTrace, label, exception)
      : super(stackTrace, label, exception);
}

class NotInsertedException extends CoreException {
  NotInsertedException(StackTrace stackTrace, label, exception) : super(stackTrace, label, exception);
}

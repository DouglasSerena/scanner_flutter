abstract class StateType {}

class EmptyState extends StateType {}

class SuccessState<T> extends StateType {
  final T result;

  SuccessState(this.result);
}

class ErrorState extends StateType {
  final String message;

  ErrorState(this.message);
}

class LoadingState extends StateType {}
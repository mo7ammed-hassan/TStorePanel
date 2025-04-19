abstract class BaseDataTableStates {}

class DataTableInitial extends BaseDataTableStates {}

class DataTableLoadingState extends BaseDataTableStates {}

class DataTableLoadedState<T> extends BaseDataTableStates {
  final List<T> data;
  DataTableLoadedState(this.data);
}

class DataTableFailureState extends BaseDataTableStates {
  final String message;
  DataTableFailureState(this.message);
}

class ToggleCheckBox extends BaseDataTableStates {}

mixin RegistrableCallbacks<T> {
  List<void Function(T event)> _registeredCallbacks = [];

  void onEvent(T event) {
    _registeredCallbacks.forEach((callback) => callback(event));
  }

  void registerCallback(void Function(T event) callback) {
    _registeredCallbacks.add(callback);
  }
}

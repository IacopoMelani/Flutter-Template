mixin RegistrableCallbacks<T> {
  List<void Function(T event)> _registeredCallbacks = [];

  void notify(T event) {
    _registeredCallbacks.forEach((callback) => callback(event));
  }

  void registerCallback(void Function(T event) callback) {
    _registeredCallbacks.add(callback);
  }
}

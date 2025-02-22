import 'dart:async';

abstract class CheetahEvent {
  final DateTime timestamp;

  CheetahEvent() : timestamp = DateTime.now();
}

class EventBus {
  static final EventBus _instance = EventBus._internal();
  final Map<Type, List<Function>> _listeners = {};

  EventBus._internal();

  factory EventBus() => _instance;

  void subscribe<T extends CheetahEvent>(void Function(T) listener) {
    _listeners[T] ??= [];
    _listeners[T]!.add(listener);
  }

  void unsubscribe<T extends CheetahEvent>(void Function(T) listener) {
    _listeners[T]?.remove(listener);
  }

  void publish<T extends CheetahEvent>(T event) {
    if (_listeners.containsKey(T)) {
      for (final listener in List<Function>.from(_listeners[T]!)) {
        listener(event);
      }
    }
  }

  Future<void> publishAsync<T extends CheetahEvent>(T event) async {
    if (_listeners.containsKey(T)) {
      for (final listener in List<Function>.from(_listeners[T]!)) {
        await Future(() => listener(event));
      }
    }
  }

  void clear() {
    _listeners.clear();
  }
}

final eventBus = EventBus();

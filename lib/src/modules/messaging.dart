import 'dart:async';

class Message {
  final String topic;
  final dynamic data;

  Message(this.topic, this.data);
}

class MessageBus {
  static final MessageBus _instance = MessageBus._internal();
  final Map<String, List<Function(dynamic)>> _listeners = {};

  MessageBus._internal();

  factory MessageBus() => _instance;

  void subscribe(String topic, Function(dynamic) listener) {
    _listeners[topic] ??= [];
    _listeners[topic]!.add(listener);
  }

  void unsubscribe(String topic, Function(dynamic) listener) {
    _listeners[topic]?.remove(listener);
  }

  void publish(String topic, dynamic data) {
    if (_listeners.containsKey(topic)) {
      for (final listener in List<Function>.from(_listeners[topic]!)) {
        listener(data);
      }
    }
  }

  Future<void> publishAsync(String topic, dynamic data) async {
    if (_listeners.containsKey(topic)) {
      for (final listener in List<Function>.from(_listeners[topic]!)) {
        await Future(() => listener(data));
      }
    }
  }

  void clear() {
    _listeners.clear();
  }
}

final messageBus = MessageBus();

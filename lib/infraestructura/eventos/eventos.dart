import 'dart:async';

import 'eventos_argumento.dart';

typedef EventHandler<T extends EventArgs> = void Function(T? args);

class Event<T extends EventArgs>
{
  late final List<EventHandler<T>> _handlers = [];

  void subscribe(EventHandler<T> handler)
  {
    _handlers.add(handler);
  }

  void subscribeStream(StreamSink sink)
  {
    _handlers.add((args) => {sink.add(args)});
  }

  bool unsubscribe(EventHandler<T> handler)
  {
    return _handlers.remove(handler);
  }

  bool operator -(EventHandler<T> handler)
  {
    return unsubscribe(handler);
  }

  void unsubscribeAll()
  {
    _handlers.clear();
  }

  int get subscriberCount
  {
    return _handlers.length;
  }

  void broadcast([T? args])
  {
    for (var i = 0; i < _handlers.length; i++)
    {
      _handlers[i].call(args);
    }
  }

  @override
  String toString()
  {
    return runtimeType.toString();
  }
}
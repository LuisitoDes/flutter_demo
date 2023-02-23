
abstract class EventArgs {}

class WhenWhy extends EventArgs
{
  DateTime whenOccurred;
  String description;
  WhenWhy({this.description = ''}) : whenOccurred = DateTime.now();
}

class Value<T> extends EventArgs
{
  T value;
  Value(this.value);
}

class Values<T1, T2> extends EventArgs
{
  T1 value1;
  T2 value2;

  Values(this.value1, this.value2);
}
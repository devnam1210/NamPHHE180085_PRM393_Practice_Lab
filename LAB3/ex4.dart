void main() async{
  print("--- EXERCISE 4 ---");
  Stream<int> numbers = Stream.fromIterable([1, 2, 3, 4, 5]);
  await numbers
      .map((n) => n * n)
      .where((n) => n % 2 != 0) 
      .listen((val) => print("Stream filter & map: $val"))
      .asFuture();
}
void main() {
  // List
  List<int> numbers = [1, 2, 3, 4, 5];
  numbers.remove(1);
  numbers.add(6);
  print("List after modifications: $numbers");
  print("Length of the list: ${numbers.length}");

  // Set
  Set<String> fruits = {"Apple", "Banana", "Orange", "Apple"};
  print("Set of fruits: $fruits");

  // Map 
  Map<String, int> ages = {
    "Nam": 25,
    "Huyen": 30,
    "Hoa": 35,
  };
  print("Hoa's age: ${ages['Hoa']}");

  // Toán tử số học, logic, toán tử 3 ngôi
  int a = 10;
  int b = 5;
  bool isGreater = a > b;

  int sum = a + b;
  print("Sum of a and b: $sum");

  String result = isGreater ? "a is greater than b" : "a is not greater than b";
  print(result);
}
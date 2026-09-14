Future<String> fetchDataLoading() async {
  print("Loading....");
  await Future.delayed(Duration(seconds: 10));
  return "Loading complete!";
}

Stream<int> countStream(int to) async* {
  for (int i = 1; i <= to; i++) {
    await Future.delayed(Duration(seconds: 1));
    yield i;
  }
}

void main() async{
  String? footballTeam;
  print("Foodball team: ${footballTeam ?? "No team selected"}");
  footballTeam = "Manchester United";
  print("I love $footballTeam have been supporting them for ${footballTeam!.length} years");
  print("");
  String loadingMessage = await fetchDataLoading();
  print(loadingMessage);

  countStream(3).listen((number) {
    print("Count: $number");
  });
}
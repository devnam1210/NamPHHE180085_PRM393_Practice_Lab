void checkScore(double score) {
  if(score >= 5.0){
    print("Passed");
  } else{
    print("Failed");
  }
}

void main(){
  double score = 7.5;
  checkScore(score);

  int day = 6;
  switch(day){
    case 1:
      print("Monday");
      break;
    case 2:
      print("Tuesday");
      break;
    case 3:
      print("Wednesday");
      break;
    case 4:
      print("Thursday");
      break;
    case 5:
      print("Friday");
      break;
    case 6:
      print("Saturday");
      break;
    case 7:
      print("Sunday");
      break;
    default:
      print("Invalid day");
  }

  List<String> colors = ["Red", "Green", "Blue"];
  for(int i = 0; i < colors.length; i++){
    print("Color at index $i: ${colors[i]}");
  }

  for(String color in colors){
    print("Color: $color");
  }
}
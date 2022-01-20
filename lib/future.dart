import 'dart:io';

void main() async {
  // cleanRooms()
  //     .then((value) => print("Rooms are Cleaned"))
  //     .onError((error, stackTrace) => print('error is $error'));
  // await washClothes();
  // print("Clothes are Washed");
  // await washDishes();
  // print("Dishes are Washed ");
  // washClothes().then((value) {
  //   print("Clothes are Washed");
  //   return washDishes();
  // }).then((value) => print("Dishes are Washed "));
  // washDishes().then((value) => print("Dishes are Washed "));
  // getDataFromServer().then((value) => print(value));
  String fullname = await getDataFromServer();
  print(fullname);
}

Future<void> cleanRooms() {
  print("Cleaning Rooms");
  return Future.delayed(Duration(seconds: 3));
}

Future<void> washClothes() {
  print("Washing  Clothes");
  return Future.delayed(Duration(seconds: 10));
}

Future<void> washDishes() {
  print("Washing Dishes");
  return Future.delayed(Duration(seconds: 6));
}

Future<String> getDataFromServer() {
  return Future.delayed(Duration(seconds: 5))
      .then((value) => "Saed Fathi imigrated to Deauchland");
}

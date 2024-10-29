//class to check user's name and password for participating in the quiz
//login function
//function can return user's question and answer and score at each attempt

//flow of the process
//- for new user
//0. login
//1. get user input
//2. check user's password
//3. convert input to json format //TODO:
//4. save json data

//-for current user
//0. sign up
//1. get user's input
//2. check user's password


// Signup Logic:
// Unique Username: The username must not already exist in userStorage.
// Unique Key: The key must also be unique across all users,
// which means no two users can have the same key,
// even if their usernames are different.

import 'dart:convert';
import 'dart:io';

class User {

  //constructor
  User();

  //Storage for user
  final Map<String, UserAccount> userStorage = {};

  //method login, check duplicate key, signup, show result of each attempt
  UserAccount? login(String userName, String key) {

    // Check if userName exists in the map
    if (userStorage.containsKey(userName)) {
      UserAccount? currentName = userStorage[userName];

      // Check if currentName is not null and if the key is correct
      if (currentName != null && currentName._key == key) {
        print('Welcome ${currentName._name}');
        return currentName;
      } else {
        print('Incorrect key for user $userName');
      }
    } else {
      print('User $userName not found.');
    }

    return null;
  }

  //check for duplicate key
  UserAccount? checkDuplicate(String key) {
    // Loop through userStorage to check for duplicates
    for (UserAccount account in userStorage.values) {
      // Check if both key and name match
      if (account._key == key) {
        throw Exception('Duplicate key found!!!');
      }
    }
    // If no duplicate is found
    return null;
  }

  //sign up
  UserAccount? signUp(String userName, String key){

    try{
      //check if name already exist
      if(userStorage.containsKey(userName)){
        throw Exception("$userName already exist!!");
      }

      checkDuplicate(key);

      //if no duplicate and no exist name create user and store in userStorage and convert userStorage to jsonFormat and write jsonFormat to json file
      UserAccount newUser = UserAccount(userName: userName, userKey: key, userResult: {});
      userStorage[userName] = newUser;

      saveUser();

      print('Sign up successfully');

      return newUser;

    }catch(e){
      print('$e');
      return null;
  }
  }

  //convert user account to json format
  String toJsonFormat(){
    Map<String, dynamic> jsonMap = userStorage.map((userName, userAccount) => MapEntry(userName, userAccount.toJson()));
    return jsonEncode(jsonMap);
  }

  //save return value of toJsonFormat() to user_data.json
  Future<void> saveUser() async {
    //get userStorage that have been convert to jsonFormat
    String jsonData = toJsonFormat();
    //file that store jsonData
    File file = File('src/project/quiz_system/data/user_data.json');
    //read jsonData to that file
    try{
      await file.writeAsString(jsonData);
      print('Saved successfully.');
    }catch(e){
      print('Error saving json data: $e');
    }
  }
}

class UserAccount {
  //user's attribute
  final String _name;
  final String _key;
  final Map<int, int> _result;

  //constructor
  UserAccount(
      {required String userName,
      required String userKey,
      required Map<int, int> userResult})
      : _name = userName,
        _key = userKey,
        _result = userResult;


  //convert user account to JSON
  Map<String, dynamic> toJson() {
    //return in json format
    return {
      "name": _name,
      "key": _key,
      "result": _result,
    };
  }
  @override
  String toString() {
    return 'UserStorage[Name: $_name, Key: $_key, Result: $_result]';

  } //getter
  Map<int, int> get result => _result;
  String get key => _key;
  String get name => _name;
}



//class to check user's name and password for participating in the quiz
//login function
//function can return user's question and answer and score at each attempt

//flow of the process
//- for new user
//0. login
//1. get user input
//2. check user's password
//3. convert input to json format
//4. save json data

//-for current user
//0. sign up
//1. get user's input
//2. check user's password
//3. convert input to json format
//4. save json data

// Signup Logic:
// Unique Username: The username must not already exist in userStorage.
// Unique Key: The key must also be unique across all users,
// which means no two users can have the same key,
// even if their usernames are different.

import 'package:test/expect.dart';

import '../sort_json.dart';

class User {
  //user's attribute
  final int _id;

  //constructor
  User({required int id})
      : _id = id;

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
        throw Exception('Duplicate key found');
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
        return null;
      }

      //if no duplicate key
      if(checkDuplicate(key) != null){
        throw Exception('This key is already use!!');
      }

      //if no duplicate and no exist name
      UserAccount newUser = UserAccount(userName: userName, userKey: key, userAttempt: 0, userScore: 0);
      userStorage[userName] = newUser;

      print('Sign up successfully');

      return newUser;

    }catch(e){
      throw Exception('Error: $e');
  }
  }



  @override
  String toString() {
    return 'User[Id: $_id]';
  }

  //getter
  int get id => _id;
}

class UserAccount {
  //user's attribute
  final String _name;
  final String _key;
  final int _attempt;
  final int _score;

  //constructor
  UserAccount(
      {required String userName,
      required String userKey,
      required int userAttempt,
      required int userScore})
      : _name = userName,
        _key = userKey,
        _attempt = userAttempt,
        _score = userScore;


  @override
  String toString() {
    return 'UserStorage[Name: $_name, Key: $_key, Attempt: $_attempt, Score: $_score]';

  } //getter
  int get score => _score;
  int get attempt => _attempt;
  String get key => _key;
  String get name => _name;
}


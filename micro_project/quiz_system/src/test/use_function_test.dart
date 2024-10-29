import '../user_data/user.dart';

void main(){
  User user = User();

  //add user
  try{
    user.signUp("pich", '123');
  }catch(e){
    print(e);
  }

  //incorrect signup with duplicate key and name
  try{
    user.signUp("pich" ,'123');
  }catch(e){
    print(e);
  }

  //incorrect signup with duplicate name and unique key
  try{
    user.signUp("pich" ,'12');
  }catch(e){
    print(e);
  }

  //correct signup with duplicate key and unique name
  try{
    user.signUp("nha" ,'123');
  }catch(e){
    print(e);
  }



  //correct login
  try{
    user.login("pich", '123');
  }catch(e){
    print(e);
  }

  //incorect login with right key
  try{
    user.login("pic", '123');
  }catch(e){
    print(e);
  }

  //incorrect login with right username
  try{
    user.login("pich", '12');
  }catch(e){
    print(e);
  }

  print(user.userStorage);
}
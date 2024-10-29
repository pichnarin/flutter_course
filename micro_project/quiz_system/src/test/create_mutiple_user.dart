import '../user_data/user.dart';

void main(){

  User user = User();

  try{
    user.signUp('narinpich', '123');
    user.signUp('laysatya', '1234');
    user.signUp('laonaroth', '12345');
    user.signUp('veasnapanha', '123456');
    user.signUp('longchanpanhavath', '1234567');
  }catch(e){
    print(e);
  }

  try{
    user.login('narinpich', '123');
    user.login('laysatya', '1234');
    user.login('laonaroth', '12345');
    user.login('veasnapanha', '123456');
    user.login('longchanpanhavath', '1234567');
  }catch(e){
    print(e);
  }



}

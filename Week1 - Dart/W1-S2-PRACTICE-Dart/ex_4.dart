//TODO: Manipulate maps

import 'dart:math';

void main(){
  const pizzaPrices = {
    'margherita': 5.5,
    'pepperoni': 7.5,
    'vegetarian': 6.5,
  };

  //list of the order
  const orders = ['margherita', 'pepperoni', 'vegetarian'];

  //total price
  var totalPrice = 0.0;

  //calculate the total price
  for(var item in orders){
    if(pizzaPrices.containsKey(item)){
      totalPrice += pizzaPrices[item]!;
    }
  }

  //output
  print('Total price is $totalPrice');
}
class API {
  static const l1 = '192.168.1.11';
  static const l2 = '192.168.0.193';
  static const feel = '192.168.1.79';
  // nha 
  static const nha1 = '192.168.1.9';
  static const ntro = '192.168.1.29';
  static const nfeel = '192.168.1.66';
  static const baseUrlAPI = 'http://$ntro:80/food_app';
  static const signIn = '$baseUrlAPI/authentication/sign-in.php';
  static const signUp = '$baseUrlAPI/authentication/sign-up.php';
  static const getAllFoods = '$baseUrlAPI/food/food.php';
  static const getAllCategory = '$baseUrlAPI/category/category.php';
  static const cart = '$baseUrlAPI/cart/cart.php';
  static const order = '$baseUrlAPI/order/order.php';
  static const getAllRestaurants = '$baseUrlAPI/restaurant/restaurant.php';
  static const reviews = '$baseUrlAPI/review/review.php';
}

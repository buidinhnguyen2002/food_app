class API {
  static const l1 = '192.168.1.11';
  static const l2 = '192.168.0.193';
  static const feel = '192.168.1.79';
  static const baseUrlAPI = 'http://$feel:80/food_app';
  static const signIn = '$baseUrlAPI/authentication/sign-in.php';
  static const signUp = '$baseUrlAPI/authentication/sign-up.php';
  static const getAllFoods = '$baseUrlAPI/food/food.php';
  static const getAllCategory = '$baseUrlAPI/category/category.php';
  static const cart = '$baseUrlAPI/cart/cart.php';
  static const order = '$baseUrlAPI/order/order.php';
  static const getAllRestaurants = '$baseUrlAPI/restaurant/restaurant.php';
}

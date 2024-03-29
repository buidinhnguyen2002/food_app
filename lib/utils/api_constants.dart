class API {
  static const l1 = '192.168.1.5';
  static const l2 = '192.168.0.193';
  static const feel = '192.168.1.24';
  static const khoa = '10.50.90.139';
  // nha
  static const nha1 = '192.168.64.1';
  static const ntro = '192.168.1.29';
  static const nfeel = '192.168.1.32';
  static const baseUrlAPI = 'http://$feel:80/food_app';
  static const signIn = '$baseUrlAPI/authentication/sign-in.php';
  static const signUp = '$baseUrlAPI/authentication/sign-up.php';
  static const getAllFoods = '$baseUrlAPI/food/food.php';
  static const getAllCategory = '$baseUrlAPI/category/category.php';
  static const cart = '$baseUrlAPI/cart/cart.php';
  static const order = '$baseUrlAPI/order/order.php';
  static const getAllRestaurants = '$baseUrlAPI/restaurant/restaurant.php';
  static const reviews = '$baseUrlAPI/review/review.php';
  static const address = '$baseUrlAPI/address/address.php';
}

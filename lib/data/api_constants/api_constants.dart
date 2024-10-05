class ApiConstants {
  static const String baseUrl = 'https://10.0.2.2:3000/api';
  static const String getAllProducts = '$baseUrl/get-all-products';
  static const String getProductsByCategory = '$baseUrl/get-products-by-category';
  static const String getCategories = '$baseUrl/get-categories';
  static const String loginUrl = '$baseUrl/login';
  static const String registerUrl = '$baseUrl/register';
  static const String forgotPasswordUrl = '$baseUrl/forgot-password';
  static const String updatePassword = '$baseUrl/user/change-password';
  static const String createCart = '$baseUrl/carts';
  static const String getCart = '$baseUrl/getCart';
  static const String deleteProductInCart = '$baseUrl/delete-product-in-cart';
  static const String checkout = '$baseUrl/payments';
  static const String getAndCreateCards = '$baseUrl/cards';
  static const String deleteCard = '$baseUrl/cards/delete-by-token';
}
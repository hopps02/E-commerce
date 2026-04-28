// ignore_for_file: constant_identifier_names

import 'package:easy_localization/easy_localization.dart';

enum Translation {
  // static
  search_country,
  app_name,

  // Loading States
  loading,
  no_more,
  failed_loading,
  load_more,
  retry_button,

  // Error Messages
  error_invalid_number,
  error_invalid_email,
  error_server,
  error_no_internet,
  error_generic,
  user_not_confirmed,
  unauthorized,
  email_taken,
  incorrect_password_or_email,

  // Auth & Onboarding
  login,
  enter_mobile_to_continue,
  mobile_number,
  your_mobile_number,
  welcome_to_jar,
  account_created_success,
  confirm_mobile_number,
  send_verification_code,
  verification_code_sent,
  start_shopping,
  onboarding_grocery_desc,
  resend_code,
  confirm,
  next,

  // Home & Shopping
  deliver_to,
  categories,
  best_offers,
  product_details,
  search_hint,
  vegetables,
  fruits,
  dairy,
  grocery_items,
  daily_needs,
  grocery,
  carefully_selected_fresh,
  save_more_today,
  fresh_daily,
  autumn_offers,
  snacks,
  juices,
  frozen_items,
  cleaners,
  available,
  save_up_to_40_on_fresh,
  package_size,
  shop_now,
  about_product,
  view_all,
  shop_fresh_easily,
  discover_latest_products,
  fresh_100_percent,
  snacks_and_packaged,
  quick_choices,
  home,

  // Cart & Orders
  product_count,
  weight_gram,
  weight_kg,
  view_cart,
  my_orders,
  cart,
  previous_orders,
  ongoing_orders,
  delivered,
  out_for_delivery,
  preparing,
  total,
  view_details,
  price_summary,
  total_products,
  shipping_cost,
  discount,
  total_amount,
}

extension Tra on Translation {
  String get tr => name.tr();
  String trNamed(Map<String, String> params) => name.tr(namedArgs: params);
}

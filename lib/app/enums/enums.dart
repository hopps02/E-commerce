


enum SuccessViewType {
  order,
  auth;

  bool get isOrder => this == order;
  bool get isAuth => this == auth;
}
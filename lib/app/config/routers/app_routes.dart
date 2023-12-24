enum AppRoutes {
  authentication,
  forgotPassword,
  verify,
  //
  main,
  dashboard,
  carts,
  activity,
  profile,
  profileUpdate,
  customers,
  products,
  productsCreate,
  employee,
  sales,
  category,
  notifications,
  chats,
  //
  camera
}

extension AppRoutesExtension on AppRoutes {
  String get path {
    switch (this) {
      case AppRoutes.authentication:
        return '/authentication';
      case AppRoutes.forgotPassword:
        return '/forgot-password';
      case AppRoutes.main:
        return '/main';
      case AppRoutes.dashboard:
        return '/dashboard';
      case AppRoutes.customers:
        return '/customers';
      case AppRoutes.products:
        return '/products';
      case AppRoutes.productsCreate:
        return '/products-create';
      case AppRoutes.sales:
        return '/sales';
      case AppRoutes.category:
        return '/category';
      case AppRoutes.profile:
        return '/profile';
      case AppRoutes.profileUpdate:
        return '/profile_update';
      case AppRoutes.activity:
        return '/activity';
      case AppRoutes.camera:
        return '/reports';
      default:
        return '';
    }
  }
}

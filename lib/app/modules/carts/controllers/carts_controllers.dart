import 'dart:developer';

import 'package:get/get.dart';

import '../../../core/helpers/app_logger.dart';
import '../../products/domain/entities/products_base_entity.dart';

class CartsController extends GetxController {
  RxList<ProductsEntity> carts = RxList<ProductsEntity>([]);

  RxBool isLoadingCarts = false.obs;
  RxBool isProductsInCart = false.obs;

  void addToCarts(ProductsEntity products) async {
    isLoadingCarts.value = true;
    try {
      bool isDuplicate = carts.any((item) => item.id == products.id);
      if (!isDuplicate) {
        carts.add(products);
        products.isInCart.value = true;
        AppLogger.logInfo(products.toString());
      } else {
        AppLogger.logInfo(
            'Duplicate ID: ${products.id}. Product not added to carts.');
      }
    } catch (e) {
      AppLogger.logError(e.toString());
    } finally {
      isLoadingCarts.value = false;
    }
  }

  RxDouble dailyRevenue = 0.0.obs;
  RxInt dailyOrderCount = 0.obs;
  Rx<ProductsEntity?> mostSoldProduct = ProductsEntity().obs;

  void checkout() {
    try {
      dailyRevenue.value = getTotal();
      dailyOrderCount.value++;

      if (carts.isNotEmpty) {
        mostSoldProduct.value = carts.fold(
          carts.first,
          (mostSold, product) =>
              product.quantity.value > mostSold!.quantity.value
                  ? product
                  : mostSold,
        );
      }
      carts.clear();
      AppLogger.logInfo('Checkout successful. Daily summary updated.');
    } catch (e) {
      AppLogger.logError('Checkout failed. Error: $e');
    } finally {
      isLoadingCarts.value = false;
    }
  }

  void increaseQuantity(int productId) {
    ProductsEntity? product =
        carts.firstWhereOrNull((item) => item.id == productId);
    if (product != null) {
      product.quantity.value++;
    }
  }

  void decreaseQuantity(int productId) {
    ProductsEntity? product =
        carts.firstWhereOrNull((item) => item.id == productId);
    if (product != null && product.quantity > 1) {
      product.quantity.value--;
    } else {
      removeProduct(productId);
      product?.isInCart.value = false;
    }
  }

  void removeProduct(int productId) {
    ProductsEntity? product =
        carts.firstWhereOrNull((item) => item.id == productId);
    carts.removeWhere((item) => item.id == productId);
    product?.isInCart.value = false;

    AppLogger.logInfo('Removed product with ID: $productId.');
  }

  RxDouble subtotal = 0.0.obs;
  RxDouble discount = 0.0.obs;
  RxDouble tax = 0.0.obs;
  RxDouble total = 0.0.obs;
  RxInt totalOrders = 0.obs;

  void updateCartCalculations() {
    subtotal.value = getSubtotal();
    discount.value = getDiscount();
    tax.value = getTax();
    total.value = getTotal();
  }

  double getSubtotal() {
    double subtotal = 0.0;
    for (var product in carts) {
      String sanitizedPrice = (product.salePrice ?? '0.0').replaceAll('.', '');
      log(sanitizedPrice);
      double price = double.parse(sanitizedPrice);
      subtotal += (product.quantity.value * price);
    }
    return subtotal;
  }

  double getDiscount() {
    return 0.0 * getSubtotal();
  }

  double getTax() {
    return 0.00 * getSubtotal();
  }

  double getTotal() {
    double subtotal = getSubtotal();
    double discount = getDiscount();
    double tax = getTax();

    double total = subtotal - discount + tax;
    return total;
  }
}

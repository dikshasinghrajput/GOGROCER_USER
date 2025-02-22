import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:user/models/addtocartmessagestatus.dart';
import 'package:user/models/businessLayer/api_helper.dart';
import 'package:user/models/businessLayer/global.dart' as global;
import 'package:user/models/cart_model.dart';
import 'package:user/models/category_product_model.dart';
import 'package:user/models/variant_model.dart';

class CartController extends GetxController {
  Cart? cartItemsList;
  APIHelper apiHelper = APIHelper();
  var isDataLoaded = false.obs;
  var isReorderDataLoaded = false.obs;
  var isReOrderSuccess = false.obs;

  Future<ATCMS?> addToCart(Product? product, int? cartQty, bool isDel, {Variant? varient, int? varientId, int? callId}) async {
    try {
      bool isSuccess = false;
      String message = '--';
      int? vId;
      if (varient != null) {
        vId = varient.varientId;
      } else {
        vId = varientId;
      }

      await apiHelper.addToCart(qty: cartQty, varientId: vId, special: 0).then((result) {
        if (result != null) {
          if (result.status == '1') {
            message = '${result.message}';
            cartItemsList = result.data;

            isSuccess = true;
            if (callId == 0) {
              // show cart screen
              if (isDel) {
                if (product!.cartQty != null && product.cartQty == 1) {
                  product.cartQty = 0;

                  // cartItemsList.cartList.remove(product);


                  global.cartCount -= 1;
                } else {
                  if (product.cartQty != null) {
                    product.cartQty = product.cartQty! - 1;
                  }
                }
              } else {
                if (product!.cartQty == null || product.cartQty == 0) {
                  product.cartQty = 1;

                  global.cartCount += 1;
                } else {
                  if (product.cartQty != null) {
                    product.cartQty = product.cartQty! + 1;
                  }
                }
              }
            } else {
              if (product!.varientId == varient!.varientId) {
                if (isDel) {
                  if (product.cartQty != null && product.cartQty == 1) {
                    product.cartQty = 0;
                    varient.cartQty = 0;
                    global.cartCount -= 1;
                  } else {
                    if (product.cartQty != null && varient.cartQty != null) {
                      product.cartQty = product.cartQty! - 1;
                      varient.cartQty = varient.cartQty! - 1;
                    }
                  }
                } else {
                  if (product.cartQty == null || product.cartQty == 0) {
                    product.cartQty = 1;
                    varient.cartQty = 1;
                    global.cartCount += 1;
                  } else {
                    if (product.cartQty != null && varient.cartQty != null) {
                      product.cartQty = product.cartQty! + 1;
                      varient.cartQty = varient.cartQty! + 1;
                    }
                  }
                }
              } else {
                if (isDel) {
                  if (varient.cartQty != null && varient.cartQty == 1) {
                    varient.cartQty = 0;
                    global.cartCount -= 1;
                  } else {
                    if (varient.cartQty != null) {
                      varient.cartQty =  varient.cartQty! - 1;
                    }
                  }
                } else {
                  if (varient.cartQty == null || varient.cartQty == 0) {
                    varient.cartQty = 1;
                    global.cartCount += 1;
                  } else {
                    if (varient.cartQty != null) {
                      varient.cartQty = varient.cartQty! + 1;
                    }
                  }
                }
              }
            }
          }
          else{
            message = '${result.message}';
          }
        } else {
          isSuccess = false;
          cartItemsList = null;
          message = 'Something went wrong please try after some time';
        }
      });

      update();
      return ATCMS(isSuccess: isSuccess, message: message);
    } catch (e) {
      debugPrint("Exception -  cart_controller.dart - addToCart():$e");
      return null;
    }
  }

  getCartList() async {
    try {
      isDataLoaded(false);
      cartItemsList = Cart();

      await apiHelper.showCart().then((result) async {
        if (result != null) {
          if (result.status == "1") {
            cartItemsList = result.data;
            global.cartCount = cartItemsList!.cartList.length;
          } else {
            cartItemsList!.cartList = [];
            global.cartCount = 0;
          }
        }
      });
      isDataLoaded(true);
      update();
    } catch (e) {
      debugPrint("Exception -  cart_controller.dart - getCartList():$e");
    }
  }
}

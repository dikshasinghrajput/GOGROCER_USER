import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:user/controllers/cart_controller.dart';
import 'package:user/models/businessLayer/global.dart' as global;
import 'package:user/widgets/bottom_button.dart';

class CartScreenBottomSheet extends StatefulWidget {
  final CartController? cartController;
  final Function()? onButtonPressed;
  const CartScreenBottomSheet({super.key, this.onButtonPressed, this.cartController});

  @override
  State<CartScreenBottomSheet> createState() => _CartScreenBottomSheetState();
}

class _CartScreenBottomSheetState extends State<CartScreenBottomSheet> {

  _CartScreenBottomSheetState();

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.tertiaryContainer,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0, top: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.txt_total_price,
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Text(
                    widget.cartController!.cartItemsList != null ? "${global.appInfo!.currencySign} ${widget.cartController!.cartItemsList!.totalMrp!.toStringAsFixed(2)}" : "${global.appInfo!.currencySign} 0",
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.txt_discount_price,
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Text(
                    widget.cartController!.cartItemsList != null ? "${global.appInfo!.currencySign} ${widget.cartController!.cartItemsList!.discountonmrp!.toStringAsFixed(2)}" : "${global.appInfo!.currencySign} 0",
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.txt_tax,
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Text(
                    widget.cartController!.cartItemsList != null ? "${global.appInfo!.currencySign} ${widget.cartController!.cartItemsList!.totalTax!.toStringAsFixed(2)}" : "${global.appInfo!.currencySign} 0",
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              const Divider(),
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.lbl_total_amount,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.cartController!.cartItemsList != null ? "${global.appInfo!.currencySign} ${widget.cartController!.cartItemsList!.totalPrice!.toStringAsFixed(2)}" : "${global.appInfo!.currencySign} 0",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              BottomButton(
                loadingState: false,
                disabledState: false,
                onPressed: () => widget.onButtonPressed!(),
                child: Text(AppLocalizations.of(context)!.btn_proceed_to_checkout),
              )
            ],
          ),
        ));
  }
}

// ignore_for_file: use_build_context_synchronously, invalid_use_of_protected_member, body_might_complete_normally_nullable, prefer_const_constructors, library_private_types_in_public_api

import 'package:dealer_portal_mobile/features/my_plans/presentation/widgets/assign_to_customer_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//TODO: clean up
final scaffoldMessengerKeyy = GlobalKey<ScaffoldMessengerState>();
Future<dynamic> assignToCustomerBottomSheet({
  required BuildContext context,
  WidgetRef? ref,
  required num amount,
  required num totalHrs,
  required int productId,
  required String itemName,
  required int validity,
}) {
  return showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    enableDrag: true,
    showDragHandle: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(16),
      ),
    ),
    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SizedBox(
          height: .3.sh,
          child: SingleChildScrollView(
            child: AssignToCustomerTile(
              amount: amount,
              totalHrs: totalHrs,
              productId: productId,
              itemName: itemName,
              validity: validity,
            ),
          ),
        ),
      );
    },
  );
}

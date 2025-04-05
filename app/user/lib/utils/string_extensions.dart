import 'package:actcms_spa_flutter/main.dart';
import 'package:actcms_spa_flutter/utils/colors.dart';
import 'package:actcms_spa_flutter/utils/images.dart';
import 'package:flutter/material.dart';

extension strEtx on String {
  Widget iconImage({double? size, Color? color, BoxFit? fit}) {
    return Image.asset(
      this,
      height: size ?? 24,
      width: size ?? 24,
      fit: fit ?? BoxFit.cover,
      color: color ?? (appStore.isDarkMode ? Colors.white : appTextSecondaryColor),
      errorBuilder: (context, error, stackTrace) {
        return Image.asset(ic_no_photo, height: size ?? 24, width: size ?? 24);
      },
    );
  }

  Color get getPaymentStatusBackgroundColor {
    switch (this) {
      case "Chưa giải quyết":
        return pendingColor;
      case "Chấp nhận":
        return acceptColor;
      case "Đang tiếp tục":
        return onGoingColor;
      case "Đang thực hiện":
        return inProgressColor;
      case "Giữ lại":
        return holdColor;
      case "Đã huỷ":
        return cancelledColor;
      case "Bị từ chối":
        return rejectedColor;
      case "Lỗi":
        return failedColor;
      case "Đã hoàn thành":
        return completedColor;

      default:
        return Color(0xFF3CAE5C);
    }
  }

  Color get getBookingActivityStatusColor {
    switch (this) {
      case "add_booking":
        return Color(0xFFEA2F2F);
      case "assigned_booking":
        return Color(0xFFFD6922);
      case "transfer_booking Going":
        return Color(0xFF00968A);
      case "update_booking_status Progress":
        return Color(0xFFFD6922);
      case "cancel_booking":
        return Color(0xFFC41520);
      case "payment_message_status":
        return Color(0xFFFFBD49);

      default:
        return Color(0xFF3CAE5C);
    }
  }
}

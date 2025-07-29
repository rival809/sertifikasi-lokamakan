import 'package:core/core.dart';

generateChipStatus(String status) {
  switch (status) {
    case 'approved':
      return const CardLabel(
        cardColor: blue50,
        cardTitle: "Sudah Verifikasi",
        cardTitleColor: blue900,
        cardBorderColor: blue200,
      );
    case 'denied':
      return const CardLabel(
        cardColor: red50,
        cardTitle: "Ditolak",
        cardTitleColor: red900,
        cardBorderColor: red200,
      );
    case 'pending':
      return const CardLabel(
        cardColor: red50,
        cardTitle: "Belum Verifikasi",
        cardTitleColor: red900,
        cardBorderColor: red200,
      );
    default:
      return const CardLabel(
        cardColor: red50,
        cardTitle: "Belum Verifikasi",
        cardTitleColor: red900,
        cardBorderColor: red200,
      );
  }
}

import 'package:base/beranda/utils/menu_beranda_model.dart';
import 'package:core/core.dart';

class MenuBeranda {
  DataUser? roleData = UserDataDatabase.userDataModel.data;

  static MenuBerandaModel _createMenuItem({
    required String text,
    required dynamic darkIcon,
    required dynamic lightIcon,
    required Function() onTap,
  }) {
    return MenuBerandaModel(
      text: text,
      icon: isDarkMode(Get.currentContext) ? darkIcon : lightIcon,
      onTap: onTap,
    );
  }

  generateMenuLayanan() {
    return [
      // _createMenuItem(
      //   text: "Info PKB",
      //   darkIcon: MediaRes.images.menu.infoPkbDark,
      //   lightIcon: MediaRes.images.menu.infoPkb,
      //   onTap: () => newRouter.push(RouterUtils.informasiPkb),
      // ),
    ];
  }
}

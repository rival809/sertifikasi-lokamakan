import 'package:base/beranda/controller/beranda_controller.dart';
import 'package:base/beranda/utils/menu_beranda_model.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

class BerandaView extends StatefulWidget {
  const BerandaView({super.key});

  Widget buildWelcomeHeader({
    required BuildContext context,
    required String? name,
  }) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.outline,
            width: 1,
          ),
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Selamat Datang! 👋",
                style: Get.theme.textTheme.bodyMedium?.copyWith(
                  color: Get.theme.colorScheme.onSecondary,
                  height: 1.5,
                ),
              ),
              Text(
                "Versi ${VersionDatabase.version} (${VersionDatabase.versionShoreBird})",
                style: Get.theme.textTheme.bodyMedium,
              ),
            ],
          ),
          Text(
            StringUtils.trimStringStrip(name),
            style: Get.theme.textTheme.titleLarge?.copyWith(
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget cardMenu({
    required BuildContext context,
    required String title,
    required String icon,
    required Function()? onTap,
  }) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border.all(
          color: Theme.of(context).colorScheme.outline,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image.asset(
                    icon,
                    height: 40,
                    width: 40,
                  ),
                ),
                const SizedBox(height: 8.0),
                SizedBox(
                  height: 32,
                  child: Text(
                    title,
                    style: Get.theme.textTheme.labelLarge,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget containerMenu({
    required BuildContext context,
    required List<MenuBerandaModel> menuItems,
    required String title,
    required String icon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              border: Border.all(
                color: Theme.of(context).colorScheme.outline,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      icon,
                      height: 24,
                      width: 24,
                    ),
                    const SizedBox(width: 12.0),
                    Text(
                      title,
                      style: Get.theme.textTheme.titleLarge,
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                StaggeredGrid.count(
                  crossAxisCount: getValueForScreenType<int>(
                    context: context,
                    mobile: 2,
                    tablet: 4,
                  ),
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  children: menuItems.map((data) {
                    return cardMenu(
                      context: context,
                      title: data.text,
                      icon: data.icon,
                      onTap: data.onTap,
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMenuSection({
    required BuildContext context,
    required List<String?> roles,
    required List<MenuBerandaModel> menuItems,
    required String title,
    required String icon,
  }) {
    return Column(
      children: [
        const SizedBox(height: 14.0),
        containerMenu(
          context: context,
          menuItems: menuItems,
          title: title,
          icon: icon,
        ),
      ],
    );
  }

  Widget build(BuildContext context, BerandaController controller) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Beranda",
        ),
        actions: const [
          SwitchThemeWidget(),
          SizedBox(width: 16.0),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildWelcomeHeader(
            context: context,
            name: controller.roleData?.name,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const BaseForm(),
                              const SizedBox(height: 16.0),
                              const BaseForm(
                                label: "Label",
                              ),
                              const SizedBox(height: 16.0),
                              BaseForm(
                                label: "Label",
                                textEditingController: TextEditingController(
                                  text: "Text",
                                ),
                                validator:
                                    Validatorless.max(20, "Max 20 karakter"),
                                autoValidate:
                                    AutovalidateMode.onUserInteraction,
                              ),
                              const SizedBox(height: 16.0),
                              BaseForm(
                                prefixIcon: const Icon(Icons.search),
                                label: "Label",
                                textEditingController: TextEditingController(
                                  text: "Text",
                                ),
                                validator:
                                    Validatorless.max(20, "Max 20 karakter"),
                                autoValidate:
                                    AutovalidateMode.onUserInteraction,
                              ),
                              const SizedBox(height: 16.0),
                              BaseForm(
                                prefixIcon: const Icon(Icons.key),
                                suffixIcon: const Icon(Icons.visibility),
                                label: "Label",
                                textEditingController: TextEditingController(
                                  text: "Text",
                                ),
                                validator:
                                    Validatorless.max(20, "Max 20 karakter"),
                                autoValidate:
                                    AutovalidateMode.onUserInteraction,
                              ),
                              const SizedBox(height: 16.0),
                              BaseForm(
                                suffixIcon: const Icon(Icons.visibility),
                                label: "Label",
                                textEditingController: TextEditingController(
                                  text: "Text",
                                ),
                                validator:
                                    Validatorless.max(20, "Max 20 karakter"),
                                autoValidate:
                                    AutovalidateMode.onUserInteraction,
                              ),
                              const SizedBox(height: 16.0),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        Expanded(
                          child: Column(
                            children: [
                              // buildMenuSection(
                              //   context: context,
                              //   roles: [
                              //     controller.roleData?.roleMenuInfoPajak,
                              //     controller.roleData?.roleMenuAwalAkhirLayanan,
                              //     controller.roleData?.roleMenuLaporanHarian,
                              //   ],
                              //   menuItems: controller.menuBeranda.generateMenuLayanan(),
                              //   title: "Menu Layanan",
                              //   icon: MediaRes.icons.layanan.workAlert,
                              // ),
                              Row(
                                children: [
                                  Expanded(
                                    child: BasePrimaryButton(
                                      prefixIcon: const Icon(Icons.add),
                                      text: "Primary Button",
                                      onPressed: () {},
                                    ),
                                  ),
                                  const SizedBox(width: 16.0),
                                  Expanded(
                                    child: BasePrimaryButton(
                                      prefixIcon: const Icon(Icons.add),
                                      text: "Primary Button",
                                      suffixIcon: const Icon(Icons.add),
                                      onPressed: () {},
                                    ),
                                  ),
                                  const SizedBox(width: 16.0),
                                  Expanded(
                                    child: BasePrimaryButton(
                                      suffixIcon: const Icon(Icons.add),
                                      text: "Primary Button",
                                      onPressed: () {},
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16.0),
                              Row(
                                children: [
                                  BasePrimaryButton(
                                    isDense: true,
                                    prefixIcon: const Icon(Icons.add),
                                    text: "Primary Button",
                                    onPressed: () {},
                                  ),
                                  const SizedBox(width: 16.0),
                                  BasePrimaryButton(
                                    isDense: true,
                                    prefixIcon: const Icon(Icons.add),
                                    text: "Primary Button",
                                    suffixIcon: const Icon(Icons.add),
                                    onPressed: () {},
                                  ),
                                  const SizedBox(width: 16.0),
                                  BasePrimaryButton(
                                    isDense: true,
                                    suffixIcon: const Icon(Icons.add),
                                    text: "Primary Button",
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16.0),

                              const BasePrimaryButton(
                                text: "Primary Button",
                                onPressed: null,
                              ),
                              const SizedBox(height: 16.0),

                              BasePrimaryButton(
                                text: "Primary Button",
                                isDense: true,
                                onPressed: () {},
                              ),
                              const SizedBox(height: 16.0),
                              const BasePrimaryButton(
                                text: "Primary Button",
                                isDense: true,
                                onPressed: null,
                              ),
                              const SizedBox(height: 16.0),
                              Row(
                                children: [
                                  Expanded(
                                    child: BaseSecondaryButton(
                                      prefixIcon: const Icon(Icons.add),
                                      text: "Secondary Button",
                                      onPressed: () {},
                                    ),
                                  ),
                                  const SizedBox(width: 16.0),
                                  Expanded(
                                    child: BaseSecondaryButton(
                                      prefixIcon: const Icon(Icons.add),
                                      text: "Secondary Button",
                                      suffixIcon: const Icon(Icons.add),
                                      onPressed: () {},
                                    ),
                                  ),
                                  const SizedBox(width: 16.0),
                                  Expanded(
                                    child: BaseSecondaryButton(
                                      suffixIcon: const Icon(Icons.add),
                                      text: "Secondary Button",
                                      onPressed: () {},
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16.0),
                              Row(
                                children: [
                                  BaseSecondaryButton(
                                    prefixIcon: const Icon(Icons.add),
                                    text: "Secondary Button",
                                    isDense: true,
                                    onPressed: () {},
                                  ),
                                  const SizedBox(width: 16.0),
                                  BaseSecondaryButton(
                                    prefixIcon: const Icon(Icons.add),
                                    text: "Secondary Button",
                                    suffixIcon: const Icon(Icons.add),
                                    isDense: true,
                                    onPressed: () {},
                                  ),
                                  const SizedBox(width: 16.0),
                                  BaseSecondaryButton(
                                    suffixIcon: const Icon(Icons.add),
                                    text: "Secondary Button",
                                    isDense: true,
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16.0),

                              BaseSecondaryButton(
                                text: "Secondary Button",
                                onPressed: () {},
                              ),
                              const SizedBox(height: 16.0),
                              const BaseSecondaryButton(
                                text: "Secondary Button",
                                onPressed: null,
                              ),
                              const SizedBox(height: 16.0),
                              BaseSecondaryButton(
                                text: "Secondary Button",
                                isDense: true,
                                onPressed: () {},
                              ),
                              const SizedBox(height: 16.0),
                              const BaseSecondaryButton(
                                text: "Secondary Button",
                                isDense: true,
                                onPressed: null,
                              ),
                              const SizedBox(height: 16.0),
                              Row(
                                children: [
                                  Expanded(
                                    child: BaseTertiaryButton(
                                      prefixIcon: const Icon(Icons.add),
                                      text: "Tertiary Button",
                                      onPressed: () {},
                                    ),
                                  ),
                                  const SizedBox(width: 16.0),
                                  Expanded(
                                    child: BaseTertiaryButton(
                                      prefixIcon: const Icon(Icons.add),
                                      text: "Tertiary Button",
                                      suffixIcon: const Icon(Icons.add),
                                      onPressed: () {},
                                    ),
                                  ),
                                  const SizedBox(width: 16.0),
                                  Expanded(
                                    child: BaseTertiaryButton(
                                      suffixIcon: const Icon(Icons.add),
                                      text: "Tertiary Button",
                                      onPressed: () {},
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16.0),
                              Row(
                                children: [
                                  BaseTertiaryButton(
                                    prefixIcon: const Icon(Icons.add),
                                    text: "Tertiary Button",
                                    isDense: true,
                                    onPressed: () {},
                                  ),
                                  const SizedBox(width: 16.0),
                                  BaseTertiaryButton(
                                    prefixIcon: const Icon(Icons.add),
                                    text: "Tertiary Button",
                                    isDense: true,
                                    suffixIcon: const Icon(Icons.add),
                                    onPressed: () {},
                                  ),
                                  const SizedBox(width: 16.0),
                                  BaseTertiaryButton(
                                    suffixIcon: const Icon(Icons.add),
                                    text: "Tertiary Button",
                                    isDense: true,
                                    onPressed: () {},
                                  ),
                                ],
                              ),

                              const SizedBox(height: 16.0),
                              BaseTertiaryButton(
                                text: "Tertiary Button",
                                onPressed: () {},
                              ),
                              const SizedBox(height: 16.0),
                              const BaseTertiaryButton(
                                text: "Tertiary Button",
                                onPressed: null,
                              ),
                              const SizedBox(height: 16.0),
                              BaseTertiaryButton(
                                text: "Tertiary Button",
                                isDense: true,
                                onPressed: () {},
                              ),
                              const SizedBox(height: 16.0),
                              const BaseTertiaryButton(
                                text: "Tertiary Button",
                                isDense: true,
                                onPressed: null,
                              ),
                              const SizedBox(height: 16.0),
                              Row(
                                children: [
                                  Expanded(
                                    child: BaseDangerButton(
                                      prefixIcon: const Icon(Icons.add),
                                      text: "Danger Button",
                                      onPressed: () {},
                                    ),
                                  ),
                                  const SizedBox(width: 16.0),
                                  Expanded(
                                    child: BaseDangerButton(
                                      prefixIcon: const Icon(Icons.add),
                                      text: "Danger Button",
                                      suffixIcon: const Icon(Icons.add),
                                      onPressed: () {},
                                    ),
                                  ),
                                  const SizedBox(width: 16.0),
                                  Expanded(
                                    child: BaseDangerButton(
                                      suffixIcon: const Icon(Icons.add),
                                      text: "Danger Button",
                                      onPressed: () {},
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16.0),
                              Row(
                                children: [
                                  BaseDangerButton(
                                    prefixIcon: const Icon(Icons.add),
                                    text: "Danger Button",
                                    isDense: true,
                                    onPressed: () {},
                                  ),
                                  const SizedBox(width: 16.0),
                                  BaseDangerButton(
                                    prefixIcon: const Icon(Icons.add),
                                    text: "Danger Button",
                                    suffixIcon: const Icon(Icons.add),
                                    isDense: true,
                                    onPressed: () {},
                                  ),
                                  const SizedBox(width: 16.0),
                                  BaseDangerButton(
                                    suffixIcon: const Icon(Icons.add),
                                    text: "Danger Button",
                                    isDense: true,
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16.0),

                              BaseDangerButton(
                                text: "Danger Button",
                                onPressed: () {},
                              ),
                              const SizedBox(height: 16.0),
                              const BaseDangerButton(
                                text: "Danger Button",
                                onPressed: null,
                              ),
                              const SizedBox(height: 16.0),
                              BaseDangerButton(
                                text: "Danger Button",
                                isDense: true,
                                onPressed: () {},
                              ),
                              const SizedBox(height: 16.0),
                              const BaseDangerButton(
                                text: "Danger Button",
                                isDense: true,
                                onPressed: null,
                              ),
                              const SizedBox(height: 16.0),
                              Row(
                                children: [
                                  Expanded(
                                    child: BaseSecondaryDangerButton(
                                      prefixIcon: const Icon(Icons.add),
                                      text: "SecondaryDanger Button",
                                      onPressed: () {},
                                    ),
                                  ),
                                  const SizedBox(width: 16.0),
                                  Expanded(
                                    child: BaseSecondaryDangerButton(
                                      prefixIcon: const Icon(Icons.add),
                                      text: "SecondaryDanger Button",
                                      suffixIcon: const Icon(Icons.add),
                                      onPressed: () {},
                                    ),
                                  ),
                                  const SizedBox(width: 16.0),
                                  Expanded(
                                    child: BaseSecondaryDangerButton(
                                      suffixIcon: const Icon(Icons.add),
                                      text: "SecondaryDanger Button",
                                      onPressed: () {},
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16.0),
                              Row(
                                children: [
                                  BaseSecondaryDangerButton(
                                    prefixIcon: const Icon(Icons.add),
                                    text: "SecondaryDanger Button",
                                    isDense: true,
                                    onPressed: () {},
                                  ),
                                  const SizedBox(width: 16.0),
                                  BaseSecondaryDangerButton(
                                    prefixIcon: const Icon(Icons.add),
                                    text: "SecondaryDanger Button",
                                    suffixIcon: const Icon(Icons.add),
                                    isDense: true,
                                    onPressed: () {},
                                  ),
                                  const SizedBox(width: 16.0),
                                  BaseSecondaryDangerButton(
                                    suffixIcon: const Icon(Icons.add),
                                    text: "SecondaryDanger Button",
                                    isDense: true,
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16.0),
                              BaseSecondaryDangerButton(
                                text: "SecondaryDanger Button",
                                onPressed: () {},
                              ),
                              const SizedBox(height: 16.0),
                              const BaseSecondaryDangerButton(
                                text: "SecondaryDanger Button",
                                onPressed: null,
                              ),
                              const SizedBox(height: 16.0),
                              BaseSecondaryDangerButton(
                                text: "SecondaryDanger Button",
                                isDense: true,
                                onPressed: () {},
                              ),
                              const SizedBox(height: 16.0),
                              const BaseSecondaryDangerButton(
                                text: "Danger Button",
                                isDense: true,
                                onPressed: null,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  State<BerandaView> createState() => BerandaController();
}

import 'package:base/admin_restaurant/controller/admin_restaurant_controller.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

class AdminRestaurantView extends StatefulWidget {
  const AdminRestaurantView({super.key});

  @override
  State<AdminRestaurantView> createState() => AdminRestaurantController();

  Widget build(BuildContext context, AdminRestaurantController controller) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            newRouter.go(RouterUtils.beranda);
          },
        ),
        title: Text(
          'Tambah Restaurant',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            controller: ScrollController(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tambah Restaurant Baru',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Masukkan nama dan deskripsi restaurant. Data lainnya (lokasi, rating, menu, dll) akan di-generate otomatis.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[600],
                      ),
                ),
                const SizedBox(height: 32),

                // Form input nama restaurant
                Text(
                  'Nama Restaurant *',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 8),
                BaseForm(
                  textEditingController: controller.nameController,
                  hintText: 'Contoh: Warung Nasi Gudeg Spesial',
                  prefixIcon: Icon(
                    Icons.restaurant,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(height: 24),

                // Form input deskripsi restaurant
                Text(
                  'Deskripsi Restaurant *',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    controller: controller.descriptionController,
                    maxLines: 4,
                    decoration: const InputDecoration(
                      hintText:
                          'Contoh: Restaurant keluarga dengan menu tradisional Indonesia yang autentik. Menyajikan berbagai hidangan khas dengan cita rasa yang lezat dan suasana yang nyaman.',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(16),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Info tentang data yang akan di-generate
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Theme.of(context).primaryColor.withOpacity(0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: Theme.of(context).primaryColor,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Data yang akan di-generate otomatis: ID unik, lokasi random di Indonesia, rating 3.5-5.0, alamat, kategori, dan menu makanan/minuman.',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Action buttons
                if (controller.isLoading)
                  const Center(child: CircularProgressIndicator())
                else
                  Row(
                    children: [
                      Expanded(
                        child: BaseSecondaryButton(
                          onPressed: controller.clearForm,
                          text: 'Bersihkan',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: BasePrimaryButton(
                          onPressed: controller.generateAndSaveRestaurant,
                          text: 'Tambah Restaurant',
                        ),
                      ),
                    ],
                  ),

                // Validation message
                if (controller.validationMessage.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(top: 16),
                    decoration: BoxDecoration(
                      color: controller.isValidationError
                          ? Colors.red.withOpacity(0.1)
                          : Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: controller.isValidationError
                            ? Colors.red
                            : Colors.green,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          controller.isValidationError
                              ? Icons.error_outline
                              : Icons.check_circle_outline,
                          color: controller.isValidationError
                              ? Colors.red
                              : Colors.green,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            controller.validationMessage,
                            style: TextStyle(
                              color: controller.isValidationError
                                  ? Colors.red
                                  : Colors.green,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

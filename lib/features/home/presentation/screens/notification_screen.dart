import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sawa_app/core/constants/text_styles.dart';
import 'package:sawa_app/features/home/widgets/empty_state_widget.dart';
import 'package:sawa_app/features/home/widgets/filter_widget.dart';
import '../controllers/notification_controller.dart';

class NotificationScreen extends GetView<NotificationController> {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              _buildHeader(),

              if (controller.notifications.isEmpty)
                // if (true)
                const Expanded(child: EmptyStateWidget())
              else ...[
                const SizedBox(height: 16),
                FilterWidget(),
                const SizedBox(height: 16),

                Expanded(
                  child: ListView.builder(
                    itemCount: controller.filteredNotifications.length,
                    itemBuilder: (_, index) {
                      final item = controller.filteredNotifications[index];
                      return Dismissible(
                        key: Key(item.id.toString()),

                        direction: DismissDirection.endToStart,

                        // من اليمين لليسار (مناسب للعربي)
                        background: Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 6,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          alignment: Alignment.centerLeft,
                          child: const Icon(
                            Icons.delete_outline,
                            color: Colors.red,
                            size: 28,
                          ),
                        ),

                        onDismissed: (_) {
                          controller.deleteNotification(item.id);
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 6,
                          ),
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: [
                              if (!item.isRead)
                                Container(
                                  width: 10,
                                  height: 10,
                                  decoration: const BoxDecoration(
                                    color: Colors.green,
                                    shape: BoxShape.circle,
                                  ),
                                ),

                              const SizedBox(width: 12),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.title,
                                      style: AppTextStyles.splashSubtitle
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    Text(item.body),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ],
          );
        }),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: const Icon(Icons.arrow_back),
          ),
          Expanded(
            child: Center(
              child: Text(
                'الإشعارات',
                style: AppTextStyles.splashSubtitle.copyWith(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
    );
  }
}

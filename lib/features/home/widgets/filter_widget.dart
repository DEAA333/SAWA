import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sawa_app/core/constants/text_styles.dart';
import 'package:sawa_app/features/home/presentation/controllers/notification_controller.dart';

class FilterWidget extends GetView<NotificationController> {
  const FilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: controller.filters.length,
        itemBuilder: (_, index) {
          final filter = controller.filters[index];

          return Obx(() {
            final active =
                controller.selectedFilter.value ==
                    filter;

            return GestureDetector(
              onTap: () =>
                  controller.changeFilter(filter),
              child: Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: 6),
                padding:
                const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  color: active
                      ? Colors.blue.shade50
                      : Colors.white,
                  borderRadius:
                  BorderRadius.circular(24),
                  border: Border.all(
                    color: active
                        ? Colors.blue
                        : Colors.grey.shade300,
                  ),
                ),
                child: Center(
                  child: Text(
                    filter,
                    style: AppTextStyles.splashSubtitle.copyWith(
                      color: active
                          ? Colors.blue
                          : Colors.black,
                    ),
                  ),
                ),
              ),
            );
          });
        },
      ),
    );
  }
}
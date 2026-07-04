import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sawa_app/core/constants/app_colors.dart';
import 'package:sawa_app/core/constants/app_sizes.dart';
import 'package:sawa_app/core/constants/text_styles.dart';
import 'package:sawa_app/features/tasks/data/models/task_model.dart';
import '../controllers/search_controller.dart';
import '../widgets/task_filter_bottom_sheet.dart';

class SearchScreen extends GetView<SearchPageController> {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              const SizedBox(height: AppSizes.paddingM),
              _buildSearchBar(context),
              const SizedBox(height: AppSizes.paddingS),
              Expanded(
                child: Column(
                    children: [
                      _buildResultsHeader(context),
                      const SizedBox(height: AppSizes.paddingS),
                      Expanded(child: _buildResultsList()),
                    ],
                  ),

              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==============================
  // الهيدر
  // ==============================
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.paddingM,
        vertical: AppSizes.paddingM,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back),
            style: IconButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
            ),
          ),
          Text(
            'البحث',
            style: AppTextStyles.splashSubtitle.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(width: 40),
        ],
      ),
    );
  }

  // ==============================
  // حقل البحث
  // ==============================
  Widget _buildSearchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingM),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.primary, width: 1.2),
        ),
        child: Row(
          children: [
            const SizedBox(width: AppSizes.paddingS),
            Icon(Icons.search, color: AppColors.primary, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                autofocus: true,
                textDirection: TextDirection.rtl,
                onChanged: controller.updateSearchText,
                style: AppTextStyles.splashSubtitle.copyWith(
                  fontSize: 14,
                  color: AppColors.textPrimary,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'بحث عن مهمة',
                  hintStyle: AppTextStyles.splashSubtitle.copyWith(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ),
            Obx(
                  () => controller.searchText.value.isNotEmpty
                  ? IconButton(
                onPressed: controller.clearSearch,
                icon: const Icon(Icons.close, size: 18),
                color: AppColors.textSecondary,
              )
                  : const SizedBox(width: AppSizes.paddingS),
            ),
          ],
        ),
      ),
    );
  }

  // ==============================
  // هيدر النتائج
  // ==============================
  Widget _buildResultsHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingM),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        textDirection: TextDirection.ltr,
        children: [
          GestureDetector(
            onTap: () => TaskFilterBottomSheet.show(context),
            child: Obx(
                  () => Row(
                children: [
                  Icon(
                    Icons.filter_list,
                    size: 18,
                    color: controller.isFilterApplied.value
                        ? AppColors.primary
                        : AppColors.textSecondary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'فلترة',
                    style: AppTextStyles.splashSubtitle.copyWith(
                      fontSize: 13,
                      color: controller.isFilterApplied.value
                          ? AppColors.primary
                          : AppColors.textSecondary,
                      fontWeight: controller.isFilterApplied.value
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Obx(
                () => Text(
                  controller.searchText.value.isEmpty
                      ? 'كل المهام'
                      : '${controller.searchResults.length} نتائج لـ "${controller.searchText.value}"',
              style: AppTextStyles.splashSubtitle.copyWith(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==============================
  // قائمة النتائج
  // ==============================
  Widget _buildResultsList() {
    return Obx(() {
      final results = controller.searchResults;
      if (results.isEmpty) return _buildNoResultsState();
      return ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingM),
        itemCount: results.length,
        separatorBuilder: (_, __) =>
        const SizedBox(height: AppSizes.paddingS),
        itemBuilder: (_, index) => _buildResultCard(results[index]),
      );
    });
  }

  Widget _buildNoResultsState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 48, color: Colors.grey.shade300),
          const SizedBox(height: AppSizes.paddingM),
          Text(
            'لا توجد نتائج مطابقة',
            style: AppTextStyles.splashSubtitle.copyWith(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  // ==============================
  // بطاقة نتيجة البحث
  // ==============================
  Widget _buildResultCard(Task item) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.paddingM),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        textDirection: TextDirection.ltr,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.shade300,
            ),
            child: const Icon(Icons.person, size: 20, color: Colors.grey),
          ),
          const SizedBox(width: AppSizes.paddingM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              textDirection: TextDirection.rtl,
              children: [
                Text(
                  item.name,
                  style: AppTextStyles.splashSubtitle.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: item.statusBackgroundColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        item.statusLabel,
                        style: AppTextStyles.splashSubtitle.copyWith(
                          fontSize: 11,
                          color: item.statusColor,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE9EFFD),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.access_time_outlined,
                              size: 12, color: AppColors.primary),
                          const SizedBox(width: 4),
                          Text(
                            item.dueDate.isEmpty ? 'اليوم' : item.dueDate,
                            style: AppTextStyles.splashSubtitle.copyWith(
                              fontSize: 11,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: item.statusColor,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }
}
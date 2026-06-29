import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sawa_app/core/constants/app_colors.dart';
import 'package:sawa_app/core/constants/app_sizes.dart';
import 'package:sawa_app/core/constants/text_styles.dart';
import 'package:sawa_app/features/tasks/data/models/task_model.dart';
import '../controllers/activities_controller.dart';

class ActivitiesScreen extends GetView<ActivitiesController> {
  const ActivitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          // الهيدر
          _buildHeader(),

          // التابين
          _buildTabs(),

          const SizedBox(height: AppSizes.paddingM),

          // المحتوى
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              return controller.selectedTab.value == 0
                  ? _buildTasksContent()
                  : _buildPurchasesContent();
            }),
          ),
        ],
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
          // placeholder
          Text(
            'الأنشطة',
            style: AppTextStyles.splashSubtitle.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
            style: IconButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
            ),
          ),
        ],
      ),
    );
  }

  // ==============================
  // التابين (المهام / المشتريات)
  // ==============================
  Widget _buildTabs() {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingM),
        child: Container(
          // decoration: BoxDecoration(
          //   color: Colors.white,
          //   borderRadius: BorderRadius.circular(12,),
          //   border: Border.all(color: AppColors.primary)
          // ),
          child: Row(
            children: [_buildTab(0, 'المهام'), _buildTab(1, 'المشتريات')],
          ),
        ),
      ),
    );
  }

  Widget _buildTab(int index, String title) {
    final active = controller.selectedTab.value == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.changeTab(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 8),
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: active ? AppColors.primary : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.primary),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: AppTextStyles.splashSubtitle.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: active ? Colors.white : AppColors.primary,
            ),
          ),
        ),
      ),
    );
  }

  // ==============================
  // محتوى المهام
  // ==============================
  Widget _buildTasksContent() {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Column(
        children: [
          // الفلاتر الفرعية
          _buildSubFilters(
            filters: controller.taskFilters,
            selected: controller.selectedTaskFilter,
            onChanged: controller.changeTaskFilter,
          ),

          const SizedBox(height: AppSizes.paddingM),

          // القائمة أو Empty state
          Expanded(
            child: Obx(() {
              final tasks = controller.filteredTasksList;
              if (tasks.isEmpty) return _buildEmptyState();
              return ListView.separated(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.paddingM,
                ),
                itemCount: tasks.length,
                separatorBuilder: (_, __) =>
                    const SizedBox(height: AppSizes.paddingS),
                itemBuilder: (_, index) {
                  final task = tasks[index];
                  return _buildDismissibleItem(
                    id: task.id,
                    onDelete: () => controller.deleteTask(task.id),
                    child: _buildTaskCard(task),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  // ==============================
  // محتوى المشتريات
  // ==============================
  Widget _buildPurchasesContent() {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Column(
        children: [
          // بطاقة إجمالي المصاريف
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingM),
            child: _buildExpensesCard(),
          ),

          const SizedBox(height: AppSizes.paddingM),

          // الفلاتر الفرعية
          _buildSubFilters(
            filters: controller.purchaseFilters,
            selected: controller.selectedPurchaseFilter,
            onChanged: controller.changePurchaseFilter,
          ),

          const SizedBox(height: AppSizes.paddingM),

          // القائمة
          Expanded(
            child: Obx(() {
              final purchases = controller.filteredPurchasesList;
              if (purchases.isEmpty) return _buildEmptyState();

              return ListView.separated(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.paddingM,
                ),
                itemCount: purchases.length,
                separatorBuilder: (_, __) =>
                    const SizedBox(height: AppSizes.paddingS),
                itemBuilder: (_, index) {
                  final purchase = purchases[index];
                  return _buildDismissibleItem(
                    id: purchase.id,
                    onDelete: () => controller.deletePurchase(purchase.id),
                    child: _buildPurchaseCard(purchase),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  // ==============================
  // بطاقة إجمالي المصاريف
  // ==============================
  Widget _buildExpensesCard() {
    return Container(
      padding: const EdgeInsets.all(AppSizes.paddingM),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        textDirection: TextDirection.rtl,
        children: [
          // النص
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'إجمالي المصاريف',
                style: AppTextStyles.splashSubtitle.copyWith(
                  fontSize: 12,
                  color: Colors.white70,
                ),
              ),
              Obx(
                () => Text(
                  '${controller.totalExpenses.value} ر.س',
                  style: AppTextStyles.splashSubtitle.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),

          // دائرة
          Obx(
            () => SizedBox(
              width: 70,
              height: 70,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CircularProgressIndicator(
                    value: controller.purchasesList.isEmpty
                        ? 0
                        : controller.purchasesList
                                  .where((p) => p.status == 'completed')
                                  .length /
                              controller.purchasesList.length,
                    strokeWidth: 6,
                    backgroundColor: Colors.white24,
                    valueColor: const AlwaysStoppedAnimation(Colors.white),
                  ),
                  Center(
                    child: Text(
                      '${controller.purchasesList.isEmpty ? 0 : ((controller.purchasesList.where((p) => p.status == 'completed').length / controller.purchasesList.length) * 100).toInt()}%',
                      style: AppTextStyles.splashSubtitle.copyWith(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
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

  // ==============================
  // الفلاتر الفرعية
  // ==============================
  Widget _buildSubFilters({
    required List<String> filters,
    required RxString selected,
    required Function(String) onChanged,
  }) {
    return SizedBox(
      height: 36,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        reverse: true,
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingM),
        itemCount: filters.length,
        itemBuilder: (_, index) {
          final filter = filters[index];
          return Obx(() {
            final active = selected.value == filter;
            return GestureDetector(
              onTap: () => onChanged(filter),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: active ? Color(0xFFE9EFFD) : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: active ? AppColors.primary : Colors.grey.shade300,
                  ),
                ),
                child: Text(
                  filter,
                  style: AppTextStyles.splashSubtitle.copyWith(
                    fontSize: 12,
                    color: active ? AppColors.primary : AppColors.textSecondary,
                    fontWeight: active ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            );
          });
        },
      ),
    );
  }

  // ==============================
  // Dismissible (Swipe للحذف والتعديل)
  // ==============================
  Widget _buildDismissibleItem({
    required String id,
    required VoidCallback onDelete,
    required Widget child,
  }) {
    return Dismissible(
      key: Key(id),
      direction: DismissDirection.startToEnd,
      confirmDismiss: (direction) async {
        // نعرض خيار حذف أو تعديل
        return await _showSwipeActions(onDelete);
      },
      background: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingM),
        decoration: BoxDecoration(
          color: Colors.red.shade50,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.delete_outline, color: Colors.red.shade400),
            const SizedBox(width: 8),
            Icon(Icons.edit_outlined, color: Colors.blue.shade400),
          ],
        ),
      ),
      child: child,
    );
  }

  Future<bool?> _showSwipeActions(VoidCallback onDelete) async {
    return await Get.dialog<bool>(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.delete_outline, color: Colors.red),
              title: const Text('حذف'),
              onTap: () {
                onDelete();
                Get.back(
                  result: false,
                ); // false = ما نحذف الـ widget (احنا حذفنا يدوي)
              },
            ),
            ListTile(
              leading: Icon(Icons.edit_outlined, color: Colors.blue.shade400),
              title: const Text('تعديل'),
              onTap: () {
                Get.back(result: false);
                // TODO: فتح شاشة التعديل
              },
            ),
          ],
        ),
      ),
    );
  }

  // ==============================
  // بطاقة المهمة
  // ==============================
  Widget _buildTaskCard(Task task) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.paddingM),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          // صورة المستخدم
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

          // التفاصيل
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  task.name,
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
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // الحالة
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: task.status == 'completed'
                            ? Colors.green.shade50
                            : Colors.orange.shade50,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        task.status == 'completed' ? 'مكتملة' : 'معلقة',
                        style: AppTextStyles.splashSubtitle.copyWith(
                          fontSize: 11,
                          color: task.status == 'completed'
                              ? Colors.green
                              : Colors.orange,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    // التاريخ
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE9EFFD),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.access_time_outlined,
                            size: 12,
                            color: AppColors.primary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'اليوم',
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

          // نقطة
          const SizedBox(width: 8),
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: task.status == 'completed' ? Colors.green : Colors.blue,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }

  // ==============================
  // بطاقة المشتريات
  // ==============================
  Widget _buildPurchaseCard(Task purchase) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.paddingM),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          // صورة المستخدم
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

          // التفاصيل
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  purchase.name,
                  style: AppTextStyles.splashSubtitle.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // السعر
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.orange.shade50,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'بانتظار الشراء',
                        style: AppTextStyles.splashSubtitle.copyWith(
                          fontSize: 11,
                          color: Colors.orange,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    // الفئة
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE9EFFD),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        purchase.category,
                        style: AppTextStyles.splashSubtitle.copyWith(
                          fontSize: 11,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // نقطة
          const SizedBox(width: 8),
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: purchase.status == 'completed'
                  ? Colors.green
                  : Colors.blue,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }

  // ==============================
  // Empty State
  // ==============================
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              Icons.grid_view_outlined,
              size: 50,
              color: Colors.grey.shade400,
            ),
          ),
          const SizedBox(height: AppSizes.paddingL),
          Text(
            'لا توجد أنشطة اليوم',
            style: AppTextStyles.splashSubtitle.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'قم بإنشاء نشاط جديد لإدارة المهام',
            style: AppTextStyles.splashSubtitle.copyWith(
              fontSize: 13,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppSizes.paddingL),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: const Text(
              'إنشاء نشاط جديد',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

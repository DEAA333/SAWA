   import 'package:flutter/material.dart';
  import 'package:get/get.dart';
  import 'package:sawa_app/core/constants/app_colors.dart';
  import 'package:sawa_app/core/constants/app_sizes.dart';
  import 'package:sawa_app/core/constants/text_styles.dart';
  import 'package:sawa_app/core/routes/app_pages.dart';
  import 'package:sawa_app/features/tasks/data/models/task_model.dart';
  import 'package:sawa_app/features/home/presentation/controllers/home_controller.dart';
  import 'package:sawa_app/features/tasks/data/models/task_model.dart';
  class HomeBody extends GetView<HomeController> {
    const HomeBody({super.key});

    @override
    Widget build(BuildContext context) {
      return SafeArea(
        child: SingleChildScrollView(
          // ... نفس الكود يلي عندك بالظبط
          padding: EdgeInsets.symmetric(horizontal: AppSizes.paddingL),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(height: AppSizes.paddingM),

              // الشريط العلوي
              _buildTopBar(),

              const SizedBox(height: AppSizes.paddingM),

              // بطاقة الإنجاز
              _buildProgressCard(),

              const SizedBox(height: AppSizes.paddingL),
              _buildStatisticsSection(),
              const SizedBox(height: AppSizes.paddingL),

              // المهام والمشتريات
              _buildSectionTitle('المهام والمشتريات'),
              const SizedBox(height: AppSizes.paddingM),

              // قائمة المهام الديناميكية
              Obx(
                    () =>
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.tasksList.length,
                      separatorBuilder: (context, index) =>
                      const SizedBox(height: AppSizes.paddingS),
                      itemBuilder: (context, index) {
                        final task = controller.tasksList[index];
                        return _buildTaskItem(
                          task: task,
                          onTap: () {
                            _showTaskDetails(task);
                          },
                        );
                      },
                    ),
              ),

              const SizedBox(height: AppSizes.paddingXL),

            ],
          ),
        ),

      );

    }

  // ... نفس الدوال المساعدة (_buildTopBar, _buildProgressCard...)


    Widget _buildTopBar() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        textDirection: TextDirection.ltr,
        children: [
          // أيقونة الإشعارات
          Stack(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(color: Colors.grey.shade100, blurRadius: 4),
                  ],
                ),
                child: IconButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.Notifications);
                  },
                  icon: Icon(Icons.notifications_outlined),
                ),
              ),
              Obx(
                    () =>
                controller.notificationCount.value > 0
                    ? Positioned(
                  top: 4,
                  right: 4,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                )
                    : const SizedBox.shrink(),
              ),
            ],
          ),

          Row(
            textDirection: TextDirection.ltr,
            children: [
              // الاسم والتحية
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'صباح الخير',
                    style: AppTextStyles.splashSubtitle.copyWith(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  Obx(
                        () =>
                        Text(
                          controller.userName.value,
                          style: AppTextStyles.splashSubtitle.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                  ),
                ],
              ),

              // صورة المستخدم
              Container(
                margin: const EdgeInsets.all(8),
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.shade200,
                ),
                child: const Icon(Icons.person_outline, color: Colors.black),
              ),
            ],
          ),
        ],
      );
    }

    Widget _buildProgressCard() {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSizes.paddingM),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // النص
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                      () =>
                      Text(
                        '${controller.completedTasks.value}/${controller
                            .totalTasks.value} تم إنجازهم',
                        style: AppTextStyles.splashSubtitle.copyWith(
                          fontSize: 12,
                          color: Colors.white70,
                        ),
                      ),
                ),
                Text(
                  'المهام والمشتريات\nالمنجزة',
                  style: AppTextStyles.splashSubtitle.copyWith(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            // دائرة الإنجاز
            Obx(
                  () =>
                  SizedBox(
                    width: 80,
                    height: 80,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        CircularProgressIndicator(
                          value: controller.completionPercentage.value / 100,
                          strokeWidth: 8,
                          backgroundColor: Colors.white24,
                          valueColor: const AlwaysStoppedAnimation(Colors.white),
                        ),
                        Center(
                          child: Text(
                            '${controller.completionPercentage.value}%',
                            style: AppTextStyles.splashSubtitle.copyWith(
                              fontSize: 18,
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

    Widget _buildStatisticsSection() {
      return Column(
        children: [
          // الصف الأول: المهام المعلقة والنسبة
          Row(
            children: [
              // نسبة الإنجاز
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(AppSizes.paddingM),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Obx(
                            () =>
                            Text(
                              '+${controller.completionPercentage.value}%',
                              style: AppTextStyles.splashSubtitle.copyWith(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'مهام تم إنجازها',
                        style: AppTextStyles.splashSubtitle.copyWith(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(width: AppSizes.paddingM),

              // المهام المعلقة
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(AppSizes.paddingM),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Obx(
                            () =>
                            Text(
                              '${controller.tasksList
                                  .where((t) => t.status  == 'pending')
                                  .length}',
                              style: AppTextStyles.splashSubtitle.copyWith(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'مهام في قائمة الإنتظار',
                        style: AppTextStyles.splashSubtitle.copyWith(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: AppSizes.paddingM),

          // الصف الثاني: النقاط والمقارنة
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppSizes.paddingM,
              vertical: AppSizes.paddingS,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // النقاط الإجمالية
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                          () =>
                          Row(
                            children: [
                              Text(
                                '${controller.totalPoints.value} ',
                                style: AppTextStyles.splashSubtitle.copyWith(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                '₪',
                                style: AppTextStyles.splashSubtitle.copyWith(),
                              ),
                            ],
                          ),
                    ),
                    Text(
                      'إجمالي المشتريات لهذا الشهر',
                      style: AppTextStyles.splashSubtitle.copyWith(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),

                // المقارنة
                Text(
                  ' مقارنة بالشهر الماضي ↑',
                  style: AppTextStyles.splashSubtitle.copyWith(
                    fontSize: 12,
                    color: Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: AppSizes.paddingS),
        ],
      );
    }

    Widget _buildSectionTitle(String title) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppTextStyles.splashSubtitle.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: AppColors.primary,
            ),
            child: IconButton(

              onPressed: () => _showAddBottomSheet(),
              icon: const Icon(Icons.add),
              iconSize: 30,
              color: Colors.white,
            ),
          ),
        ],
      );
    }

    // تحديث _buildTaskItem في home_screen.dart

    Widget _buildTaskItem({required Task  task, required VoidCallback onTap}) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(AppSizes.paddingM),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // الدائرة الزرقاء
              Container(
                width: 12,
                height: 12,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
              ),

              // الوسط: الاسم والحالة والتاريخ
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.paddingM,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // اسم المهمة
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

                      const SizedBox(height: 8),

                      // الحالة والتاريخ
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // التاريخ والوقت
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xFFE9EFFD),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.access_time_outlined,
                                  size: 14,
                                  color: AppColors.primary,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'اليوم - 10:00 ص',
                                  style: AppTextStyles.splashSubtitle.copyWith(
                                    fontSize: 11,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(width: 8),

                          // الحالة
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),

                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 6,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    color: task.status == 'completed'
                                        ? Colors.green
                                        : Colors.orange,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  task.status == 'completed' ? 'منجزة' : 'معلقة',
                                  style: AppTextStyles.splashSubtitle.copyWith(
                                    fontSize: 11,
                                    color: task.status == 'completed'
                                        ? Colors.green
                                        : Colors.orange,
                                    fontWeight: FontWeight.w600,
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
              ),

              // صورة المستخدم على اليسار
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.shade300,
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/user_avatar.png',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.person,
                        size: 20,
                        color: Colors.grey,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    void _showTaskDetails(Task task) {
      print('Task tapped: ${task.name}');
    }

    void _showAddBottomSheet() {
      Get.bottomSheet(
        Container(
          padding: const EdgeInsets.all(AppSizes.paddingL),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // خط علوي
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: AppSizes.paddingL),

              // العنوان
              Text(
                'إضافة جديدة',
                style: AppTextStyles.splashSubtitle.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'اختر نوع العنصر الذي تريد إضافته',
                style: AppTextStyles.splashSubtitle.copyWith(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                ),
              ),

              const SizedBox(height: AppSizes.paddingL),

              // خيار مهمة جديدة
              _buildAddOption(
                icon: Icons.task_alt_outlined,
                title: 'مهمة جديدة',
                subtitle: 'أضف مهمة لأحد أفراد العائلة',
                onTap: () {
                  Get.back();
                  Get.toNamed(AppRoutes.ADD_TASK);
                },
              ),

              const SizedBox(height: AppSizes.paddingM),

              // خيار مشتريات جديدة
              _buildAddOption(
                icon: Icons.shopping_cart_outlined,
                title: 'مشتريات جديدة',
                subtitle: 'أضف عنصر لقائمة المشتريات',
                onTap: () {
                  Get.back();
                  Get.toNamed(AppRoutes.ADD_PURCHASE);
                },
              ),

              const SizedBox(height: AppSizes.paddingL),
            ],
          ),
        ),
      );
    }

    Widget _buildAddOption({
      required IconData icon,
      required String title,
      required String subtitle,
      required VoidCallback onTap,
    }) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(AppSizes.paddingM),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade200),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade100,
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // سهم
              const Icon(Icons.arrow_back_ios, size: 16, color: Colors.grey),

              // النص
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.paddingM),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        title,
                        style: AppTextStyles.splashSubtitle.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: AppTextStyles.splashSubtitle.copyWith(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // أيقونة
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: AppColors.primary),
              ),
            ],
          ),
        ),
      );
    }
  }

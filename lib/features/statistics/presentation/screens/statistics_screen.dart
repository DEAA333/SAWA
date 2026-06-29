import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sawa_app/core/constants/app_colors.dart';
import 'package:sawa_app/core/constants/app_sizes.dart';
import 'package:sawa_app/core/constants/text_styles.dart';
import '../controllers/statistics_controller.dart';

class StatisticsScreen extends GetView<StatisticsController> {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return SingleChildScrollView(
          padding: const EdgeInsets.all(AppSizes.paddingM),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // الهيدر
                _buildHeader(),
                const SizedBox(height: AppSizes.paddingM),

                // الفلاتر
                _buildFilters(),
                const SizedBox(height: AppSizes.paddingM),

                // الرسم البياني + الإجمالي
                _buildChartCard(),
                const SizedBox(height: AppSizes.paddingM),

                // معدل الإنجاز + أكثر الأعضاء
                _buildMiddleRow(),
                const SizedBox(height: AppSizes.paddingM),

                // الفئات
                _buildCategoriesCard(),
                const SizedBox(height: AppSizes.paddingM),

                // التوصيات الذكية
                _buildSmartTipsCard(),
                const SizedBox(height: AppSizes.paddingXL),
              ],
            ),
          ),
        );
      }),
    );
  }

  // ==============================
  // الهيدر
  // ==============================
  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      textDirection: TextDirection.rtl,
      children: [
        IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_forward),
        ),
        Text(
          'الإحصائيات',
          style: AppTextStyles.splashSubtitle.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        IconButton(onPressed: () {}, icon: Icon(Icons.search_outlined)),
      ],
    );
  }

  // ==============================
  // الفلاتر الزمنية
  // ==============================
  Widget _buildFilters() {
    return Obx(
      () => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        reverse: true,
        child: Row(
          textDirection: TextDirection.rtl,
          children: controller.filters.map((filter) {
            final active = controller.selectedFilter.value == filter;
            return GestureDetector(
              onTap: () => controller.changeFilter(filter),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
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
                    fontSize: 13,
                    color: active ? AppColors.primary : AppColors.textSecondary,
                    fontWeight: active ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  // ==============================
  // بطاقة الرسم البياني
  // ==============================
  Widget _buildChartCard() {
    return Container(
      padding: EdgeInsets.all(AppSizes.paddingM),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        textDirection: TextDirection.rtl,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // الإجمالي
          Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // الإجمالي
                Text(
                  'مصروفات هذا الأسبوع',
                  style: AppTextStyles.splashSubtitle.copyWith(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '₪',
                      style: AppTextStyles.splashSubtitle.copyWith(
                        fontSize: 14,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${controller.totalExpenses.value.toInt()}',
                      style: AppTextStyles.splashSubtitle.copyWith(
                        fontSize: 31,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                // نسبة التغيير
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: controller.isIncreased.value
                        ? Colors.red.shade50
                        : Colors.green.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        textDirection: TextDirection.rtl,
                        '${controller.changePercentage.value.toInt()}% مقارنة بالشهر الماضي',
                        style: AppTextStyles.splashSubtitle.copyWith(
                          fontSize: 11,
                          color: controller.isIncreased.value
                              ? Colors.red
                              : Colors.green,
                        ),
                      ),
                      Icon(
                        controller.isIncreased.value
                            ? Icons.arrow_upward
                            : Icons.arrow_downward,
                        size: 14,
                        color: controller.isIncreased.value
                            ? Colors.red
                            : Colors.green,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: AppSizes.paddingL),

          // الرسم البياني
          Obx(
            () => SizedBox(
              height: 150,
              width: 200,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY:
                      controller.chartData
                          .map((e) => e.amount)
                          .reduce((a, b) => a > b ? a : b) *
                      1,
                  barTouchData: BarTouchData(enabled: false),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          final index = value.toInt();
                          if (index >= controller.chartData.length) {
                            return const SizedBox.shrink();
                          }
                          return Text(
                            controller.chartData[index].day,
                            style: AppTextStyles.splashSubtitle.copyWith(
                              fontSize: 10,
                              color: AppColors.textSecondary,
                            ),
                          );
                        },
                      ),
                    ),
                    leftTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  gridData: FlGridData(
                    show: false,
                    drawVerticalLine: false,
                    getDrawingHorizontalLine: (value) =>
                        FlLine(color: Colors.grey.shade200, strokeWidth: 1),
                  ),
                  borderData: FlBorderData(show: false),
                  barGroups: controller.chartData
                      .asMap()
                      .entries
                      .map(
                        (entry) => BarChartGroupData(
                          x: entry.key,
                          barRods: [
                            BarChartRodData(
                              toY: entry.value.amount,
                              color:
                                  entry.key == controller.chartData.length - 1
                                  ? AppColors.primary
                                  : Colors.grey.shade300,
                              width: 16,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ],
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==============================
  // الصف الأوسط: معدل الإنجاز + الأعضاء
  // ==============================
  Widget _buildMiddleRow() {
    return Row(
      children: [
        // أكثر الأعضاء إنجازاً
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(AppSizes.paddingM),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'أكثر الأعضاء إنجازاً',
                  style: AppTextStyles.splashSubtitle.copyWith(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: AppSizes.paddingS),
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: controller.topMembers
                        .asMap()
                        .entries
                        .map(
                          (entry) => Transform.translate(
                            offset: Offset(entry.key * 4, 5),
                            child: Container(
                              padding: EdgeInsets.zero,
                              margin: EdgeInsets.zero,
                              width: 30,
                              height: 53,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                                color: Colors.grey.shade300,
                              ),
                              child: ClipOval(
                                child: Image.asset(
                                  entry.value.avatar,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => const Icon(
                                    Icons.person,
                                    size: 18,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(width: AppSizes.paddingM),

        // معدل الإنجاز
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(AppSizes.paddingM),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Center(
                  child: Text(
                    'معدل الإنجاز',
                    style: AppTextStyles.splashSubtitle.copyWith(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
                const SizedBox(height: AppSizes.paddingS),
                Obx(
                  () => Text(
                    '${(controller.completionRate.value * 100).toInt()}%',
                    style: AppTextStyles.splashSubtitle.copyWith(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Obx(
                  () => Directionality(
                    textDirection: TextDirection.rtl,
                    child: ClipRRect(
                       child: LinearProgressIndicator(
                        value: controller.completionRate.value,
                        backgroundColor: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(15),
                        valueColor: AlwaysStoppedAnimation(AppColors.primary),
                        minHeight:8,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ==============================
  // الفئات
  // ==============================
  Widget _buildCategoriesCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,

      children: [
        Text(
          'الفئات',
          style: AppTextStyles.splashSubtitle.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: AppSizes.paddingM),
        Container(
          padding: const EdgeInsets.all(AppSizes.paddingM),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Obx(
            () => Column(
              children: controller.categories.map((cat) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${cat.percentage.toInt()}%',
                            style: AppTextStyles.splashSubtitle.copyWith(
                              fontSize: 13,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          Text(
                            cat.name,
                            style: AppTextStyles.splashSubtitle.copyWith(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: cat.percentage / 100,
                            backgroundColor: Color(0xFFE9EFFD),
                            borderRadius: BorderRadius.circular(15),
                            valueColor: const AlwaysStoppedAnimation(
                              AppColors.primary,
                            ),
                            minHeight: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  // ==============================
  // التوصيات الذكية
  // ==============================
  Widget _buildSmartTipsCard() {
    return Container(
      padding: const EdgeInsets.all(AppSizes.paddingM),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F4FF),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // العنوان مع أيقونة
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'توصيات ذكية',
                style: AppTextStyles.splashSubtitle.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(width: 8),
              const Text('🤖', style: TextStyle(fontSize: 18)),
            ],
          ),
          const SizedBox(height: AppSizes.paddingM),

          // قائمة التوصيات
          Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: controller.smartTips.map((tip) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    textDirection: TextDirection.rtl,
                    children: [
                        Text(
                        '•',
                        style: AppTextStyles.splashSubtitle.copyWith(
                          color: AppColors.primary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          tip.text,
                          textAlign: TextAlign.right,
                          style: AppTextStyles.splashSubtitle.copyWith(
                            fontSize: 13,
                            color: AppColors.textPrimary,
                            height: 1.6,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

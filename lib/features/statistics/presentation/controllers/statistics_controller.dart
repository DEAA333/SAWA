import 'package:get/get.dart';

// موديل بيانات الرسم البياني
class ChartData {
  final String day;
  final double amount;
  const ChartData(this.day, this.amount);
}

// موديل فئة المصاريف
class CategoryData {
  final String name;
  final double percentage;
  const CategoryData(this.name, this.percentage);
}

// موديل توصية ذكية
class SmartTip {
  final String text;
  const SmartTip(this.text);
}

// موديل أكثر الأعضاء إنجازاً
class TopMember {
  final String name;
  final String avatar; // مسار الصورة
  const TopMember(this.name, this.avatar);
}

class StatisticsController extends GetxController {
  // ==============================
  // الفلاتر الزمنية
  // ==============================
  final selectedFilter = 'هذا الأسبوع'.obs;
  final filters = ['هذا الأسبوع', 'الشهر', '3 أشهر', 'سنة'];

  // ==============================
  // بيانات الرسم البياني
  // ==============================
  final chartData = <ChartData>[].obs;
  // TODO (API): استبدل chartData.value بـ:
  // final response = await statisticsRepo.getChartData(filter: selectedFilter.value);
  // chartData.value = response.map((e) => ChartData(e.day, e.amount)).toList();

  // ==============================
  // إجمالي المصاريف
  // ==============================
  final totalExpenses = 0.0.obs;
  // TODO (API): totalExpenses.value = response.total;

  // ==============================
  // نسبة التغيير عن الفترة السابقة
  // ==============================
  final changePercentage = 0.0.obs;
  final isIncreased = true.obs; // true = ارتفع، false = انخفض
  // TODO (API): changePercentage.value = response.changePercentage;
  //             isIncreased.value = response.isIncreased;

  // ==============================
  // معدل الإنجاز
  // ==============================
  final completionRate = 0.0.obs; // من 0.0 إلى 1.0
  // TODO (API): completionRate.value = response.completionRate / 100;

  // ==============================
  // أكثر الأعضاء إنجازاً
  // ==============================
  final topMembers = <TopMember>[].obs;
  // TODO (API): topMembers.value = response.topMembers.map((e) => TopMember(e.name, e.avatar)).toList();

  // ==============================
  // فئات المصاريف
  // ==============================
  final categories = <CategoryData>[].obs;
  // TODO (API): categories.value = response.categories.map((e) => CategoryData(e.name, e.percentage)).toList();

  // ==============================
  // التوصيات الذكية
  // ==============================
  final smartTips = <SmartTip>[].obs;
  // TODO (API): smartTips.value = response.tips.map((e) => SmartTip(e.text)).toList();

  // ==============================
  // حالة التحميل
  // ==============================
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadMockData(); // مؤقتاً بيانات وهمية
    // TODO (API): استبدل _loadMockData() بـ fetchStatistics()
  }

  // ==============================
  // تغيير الفلتر الزمني
  // ==============================
  void changeFilter(String filter) {
    selectedFilter.value = filter;
    _loadMockData(); // مؤقتاً
    // TODO (API): استبدل _loadMockData() بـ fetchStatistics()
  }

  // ==============================
  // TODO (API): هاد الدالة رح تستبدل _loadMockData كلياً
  // Future<void> fetchStatistics() async {
  //   isLoading.value = true;
  //   try {
  //     final response = await statisticsRepo.getStatistics(
  //       filter: selectedFilter.value,
  //     );
  //     chartData.value = response.chartData;
  //     totalExpenses.value = response.totalExpenses;
  //     changePercentage.value = response.changePercentage;
  //     isIncreased.value = response.isIncreased;
  //     completionRate.value = response.completionRate / 100;
  //     topMembers.value = response.topMembers;
  //     categories.value = response.categories;
  //     smartTips.value = response.tips;
  //   } catch (e) {
  //     Get.snackbar('خطأ', 'حدث خطأ في تحميل الإحصائيات');
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }
  // ==============================

  // بيانات وهمية مؤقتة — احذف هاد كله لما يجي الـ API
  void _loadMockData() {
    isLoading.value = true;

    Future.delayed(const Duration(milliseconds: 100), () {
      // رسم بياني حسب الفلتر
      switch (selectedFilter.value) {
        case 'هذا الأسبوع':
          chartData.value = const [
            ChartData('سبت', 200),
            ChartData('أحد', 150),
            ChartData('اثنين', 300),
            ChartData('ثلاتاء', 180),
            ChartData('أربعاء', 400),
            ChartData('خميس', 250),
            ChartData('جمعة', 1500),
          ];
          totalExpenses.value = 1500;
          changePercentage.value = 22;
          isIncreased.value = true;
          break;

        case 'الشهر':
          chartData.value = const [
            ChartData('أ1', 800),
            ChartData('أ2', 1200),
            ChartData('أ3', 900),
            ChartData('أ4', 1500),
          ];
          totalExpenses.value = 4400;
          changePercentage.value = 10;
          isIncreased.value = false;
          break;

        case '3 أشهر':
          chartData.value = const [
            ChartData('ش1', 3000),
            ChartData('ش2', 4500),
            ChartData('ش3', 3800),
          ];
          totalExpenses.value = 11300;
          changePercentage.value = 5;
          isIncreased.value = true;
          break;

        case 'سنة':
          chartData.value = const [
            ChartData('ين', 2000),
            ChartData('فب', 1800),
            ChartData('مر', 2500),
            ChartData('أب', 3000),
            ChartData('مي', 2200),
            ChartData('يو', 2800),
            ChartData('يل', 3200),
            ChartData('أغ', 2900),
            ChartData('سب', 2600),
            ChartData('أك', 3100),
            ChartData('نو', 2400),
            ChartData('دي', 1500),
          ];
          totalExpenses.value = 30000;
          changePercentage.value = 15;
          isIncreased.value = true;
          break;
      }

      completionRate.value = 0.80;

      topMembers.value = const [
        TopMember('سعيد', 'assets/images/user1.png'),
        TopMember('نورة', 'assets/images/user2.png'),
        TopMember('أحمد', 'assets/images/user3.png'),
        TopMember('ليلى', 'assets/images/user4.png'),
      ];

      categories.value = const [
        CategoryData('طعام', 65),
        CategoryData('ترفيه', 5),
        CategoryData('صحة', 10),
        CategoryData('أخرى', 20),
      ];

      smartTips.value = const [
        SmartTip('ارفع معدل إنجاز المهام بنسبة 32% مقارنة بالأسبوع الماضي.'),
        SmartTip('سجّل حافظات على ستريك تبعك لمدة 9 أيام متتالية.'),
        SmartTip('قائمة الطعام كانت الأكبر إنفاقاً إنفاقاً قبل نهاية الشهر.'),
        SmartTip('تم إكمال 18 مهمة خلال أقل من 7 أيام.'),
        SmartTip('يوجد 6 مهام تحتاج إلى إنجاز قبل نهاية اليوم.'),
        SmartTip('تم إكمال 18 مهمة خلال أقل من 7 أيام.'),
        SmartTip('توزيع المهام بين أفراد العائلة بشكل متساوٍ قد يساعد على رفع معدل الإنجاز.'),
      ];

      isLoading.value = false;
    });
  }
}
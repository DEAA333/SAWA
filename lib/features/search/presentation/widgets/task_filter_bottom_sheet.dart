import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sawa_app/core/constants/app_colors.dart';
import 'package:sawa_app/core/constants/app_sizes.dart';
import 'package:sawa_app/core/constants/text_styles.dart';
import '../controllers/search_controller.dart';

class TaskFilterBottomSheet extends StatefulWidget {
  const TaskFilterBottomSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => const TaskFilterBottomSheet(),
    );
  }

  @override
  State<TaskFilterBottomSheet> createState() => _TaskFilterBottomSheetState();
}

class _TaskFilterBottomSheetState extends State<TaskFilterBottomSheet> {
  final controller = Get.find<SearchPageController>();

  late String _status;
  late String _priority;
  late String _assigneeId;

  @override
  void initState() {
    super.initState();
    _status = controller.selectedStatusFilter.value;
    _priority = controller.selectedPriorityFilter.value;
    _assigneeId = controller.selectedAssigneeId.value;
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: EdgeInsets.only(
          left: AppSizes.paddingM,
          right: AppSizes.paddingM,
          top: AppSizes.paddingS,
          bottom: AppSizes.paddingM + MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // مقبض السحب
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: AppSizes.paddingM),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(4),
              ),
            ),

            // العنوان + إعادة تعيين
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: _resetLocal,
                  child: Text(
                    'إعادة تعيين',
                    style: AppTextStyles.splashSubtitle.copyWith(
                      fontSize: 13,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                Text(
                  'الفلاتر',
                  style: AppTextStyles.splashSubtitle.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),

            const SizedBox(height: AppSizes.paddingM),

            // الحالة
            _buildSectionTitle('الحالة'),
            const SizedBox(height: AppSizes.paddingS),
            _buildChipsWrap(
              options: controller.statusFilters,
              selected: _status,
              activeColor: AppColors.primary,
              activeBg: const Color(0xFFE9EFFD),
              onTap: (value) => setState(() => _status = value),
            ),

            const SizedBox(height: AppSizes.paddingL),

            // الأولوية
            _buildSectionTitle('الأولوية'),
            const SizedBox(height: AppSizes.paddingS),
            _buildChipsWrap(
              options: controller.priorityFilters,
              selected: _priority,
              activeColor: Colors.orange,
              activeBg: Colors.orange.shade50,
              onTap: (value) =>
                  setState(() => _priority = _priority == value ? '' : value),
            ),

            const SizedBox(height: AppSizes.paddingL),

            // الشخص المسؤول
            _buildSectionTitle('الشخص المسؤول'),
            const SizedBox(height: AppSizes.paddingS),
            _buildAssigneeList(),

            const SizedBox(height: AppSizes.paddingL),

            // زر تطبيق
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  controller.applyFilters(
                    status: _status,
                    priority: _priority,
                    assigneeId: _assigneeId,
                  );
                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Text(
                  'تطبيق الفلاتر',
                  style: AppTextStyles.splashSubtitle.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _resetLocal() {
    setState(() {
      _status = 'الكل';
      _priority = '';
      _assigneeId = '';
    });
  }

  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        title,
        style: AppTextStyles.splashSubtitle.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }

  Widget _buildChipsWrap({
    required List<String> options,
    required String selected,
    required Color activeColor,
    required Color activeBg,
    required Function(String) onTap,
  }) {
    return Wrap(
      alignment: WrapAlignment.end,
      spacing: 8,
      runSpacing: 8,
      children: options.map((option) {
        final active = selected == option;
        return GestureDetector(
          onTap: () => onTap(option),
          child: Container(
            padding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: active ? activeBg : Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: active ? activeColor : Colors.grey.shade300,
              ),
            ),
            child: Text(
              option,
              style: AppTextStyles.splashSubtitle.copyWith(
                fontSize: 13,
                color: active ? activeColor : AppColors.textSecondary,
                fontWeight:
                active ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildAssigneeList() {
    return SizedBox(
      height: 76,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        reverse: true,
        itemCount: controller.assignees.length,
        itemBuilder: (_, index) {
          final person = controller.assignees[index];
          final active = _assigneeId == person['id'];
          return GestureDetector(
            onTap: () => setState(
                  () => _assigneeId = active ? '' : person['id']!,
            ),
            child: Container(
              width: 64,
              margin: const EdgeInsets.symmetric(horizontal: 6),
              padding: const EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                color: active
                    ? const Color(0xFFE9EFFD)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color:
                  active ? AppColors.primary : Colors.transparent,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    person['avatar']!,
                    style: const TextStyle(fontSize: 22),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    person['name']!,
                    style: AppTextStyles.splashSubtitle.copyWith(
                      fontSize: 11,
                      color: active
                          ? AppColors.primary
                          : AppColors.textSecondary,
                      fontWeight: active
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
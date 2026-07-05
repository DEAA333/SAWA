import 'package:get/get.dart';
import 'package:sawa_app/core/bindings/initial_binding.dart';
import 'package:sawa_app/features/auth/presentation/bindings/forgot_password_binding.dart';
import 'package:sawa_app/features/auth/presentation/bindings/new_Password_binding.dart';
import 'package:sawa_app/features/auth/presentation/bindings/otp_binding.dart';
import 'package:sawa_app/features/auth/presentation/bindings/register_binding.dart';
import 'package:sawa_app/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:sawa_app/features/auth/presentation/screens/new_Password_screen.dart';
import 'package:sawa_app/features/auth/presentation/screens/otp_screen.dart';
import 'package:sawa_app/features/auth/presentation/screens/register_screen.dart';
import 'package:sawa_app/features/family/presentation/bindings/create_family_binding.dart';
import 'package:sawa_app/features/family/presentation/bindings/family_setup_binding.dart';
import 'package:sawa_app/features/family/presentation/bindings/join_family_binding.dart';
import 'package:sawa_app/features/family/presentation/bindings/recover_code_binding.dart';
import 'package:sawa_app/features/family/presentation/screens/create_family_screen.dart';
import 'package:sawa_app/features/family/presentation/screens/family_code_screen.dart';
import 'package:sawa_app/features/family/presentation/screens/family_setup_screen.dart';
import 'package:sawa_app/features/family/presentation/screens/join_family_screen.dart';
import 'package:sawa_app/features/family/presentation/screens/recover_code_screen.dart';
import 'package:sawa_app/features/home/presentation/bindings/home_binding.dart';
import 'package:sawa_app/features/home/presentation/bindings/notification_binding.dart';
import 'package:sawa_app/features/home/presentation/controllers/home_controller.dart';
import 'package:sawa_app/features/home/presentation/screens/home_screen.dart';
import 'package:sawa_app/features/home/presentation/screens/notification_screen.dart';
import 'package:sawa_app/features/onboarding/presentation/bindings/onboarding_binding.dart';
import 'package:sawa_app/features/auth/presentation/bindings/login_binding.dart';
import 'package:sawa_app/features/auth/presentation/screens/login_screen.dart';
import 'package:sawa_app/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:sawa_app/features/purchases/presentation/bindings/add_purchase_binding.dart';
import 'package:sawa_app/features/purchases/presentation/screens/add_purchase_screen.dart';
import 'package:sawa_app/features/statistics/presentation/bindings/statistics_binding.dart';
import 'package:sawa_app/features/statistics/presentation/screens/statistics_screen.dart';
import 'package:sawa_app/features/tasks/presentation/bindings/add_task_binding.dart';
import 'package:sawa_app/features/tasks/presentation/bindings/task_details_binding.dart';
import 'package:sawa_app/features/tasks/presentation/screens/add_task_screen.dart';
import 'package:sawa_app/features/tasks/presentation/screens/complete_task_screen.dart';
import 'package:sawa_app/features/tasks/presentation/screens/task_details_screen.dart';
import 'package:sawa_app/search/presentation/bindings/search_binding.dart';
import 'package:sawa_app/search/presentation/screens/search_screen.dart';
 import '../../features/splash/presentation/screens/splash_screen.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static final routes = [
    GetPage(
      name: AppRoutes.SPLASH,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: AppRoutes.ONBOARDING,
      page: () => const OnboardingScreen(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: AppRoutes.LOGIN,
      page: () => const LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.REGISTER,
      page: () => const RegisterScreen(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: AppRoutes.FORGOT_PASSWORD,
      page: () => const ForgotPasswordScreen(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: AppRoutes.OTP,
      page: () =>  const OtpScreen(),
      binding: OtpBinding(),
    ),
    GetPage(
      name: AppRoutes.NEW_PASSWORD,
      page: () => const NewPasswordScreen(),
      binding: NewPasswordBinding(),
    ),
    GetPage(
      name: AppRoutes.FAMILY_SETUP,
      page: () => const FamilySetupScreen(),
      binding: FamilySetupBinding(),
    ),
    GetPage(
      name: AppRoutes.CREATE_FAMILY,
      page: () => const CreateFamilyScreen(),
      binding: CreateFamilyBinding(),
    ),
    GetPage(
      name: AppRoutes.FAMILY_CODE,
      page: () => const FamilyCodeScreen(),
      // نفس الـ binding تبع create family لأنه نفس الـ controller
      binding: CreateFamilyBinding(),
    ),
    GetPage(
      name: AppRoutes.JOIN_FAMILY,
      page: () => const JoinFamilyScreen(),
      binding: JoinFamilyBinding(),
    ),
    GetPage(
      name: AppRoutes.RECOVER_CODE,
      page: () => const RecoverCodeScreen(),
      binding: RecoverCodeBinding(),
    ),
    GetPage(
      name: AppRoutes.HOME,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.Notifications,
      page: () => NotificationScreen(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: AppRoutes.STATISTICS,
      page: () => const StatisticsScreen(),
      binding: StatisticsBinding(),
    ),
    GetPage(
      name: AppRoutes.ADD_TASK,
      page: () => const AddTaskScreen(),
      binding: AddTaskBinding(),
    ),
    GetPage(
      name: AppRoutes.TASK_DETAILS,
      page: () => const TaskDetailsScreen(),
      binding: TaskDetailsBinding(),
    ),
    GetPage(
      name: AppRoutes.COMPLETE_TASK,
      page: () => const CompleteTaskScreen(),
      binding: TaskDetailsBinding(),
    ),
    GetPage(
      name: AppRoutes.SEARCH,
      page: () => const SearchScreen(),
      binding: SearchBinding(),
    ),
    GetPage(
      name: AppRoutes.ADD_PURCHASE,
      page: () => const AddPurchaseScreen(),
      binding: AddPurchaseBinding(),
    ),

  ];
}
import 'package:get/get.dart';

class LangTranslation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'hello': 'Hello',

          //Settings
          'settings': 'Settings',
          'volunteer': 'volunteer',
          'change_language': 'Change Language',
          'arabic': 'Arabic',
          'english': 'English',
          'change_password': 'Change Password',
          'logout': 'Logout',
          'change': 'Change',
          'old_password': 'Old Password',
          'new_password': 'New Password',
          'confirm_new_password': "Confirm New Password",
          'confirm_logout': 'Would you like to log out of your account?',
          'cancel': "Cancel",
          'this_field_isEmpty': 'This Field is Empty',
          "passwords_not_same": "Passwords Word Not same",
          'Edit Profile': 'Edit Profile',

          //login page
          'login': 'Login',
          'please_login': 'Please Login to continue',
          //Sign up page
          'Signup': 'Signup',
          'please_register': 'Please complete the form to creat an accouts',

          'username': 'Username',
          'password': 'Password',
          'example': 'example: Muhammmad Ahmad',
          'please_enter_username': "Please enter a username.",
          'please_enter_password': "Please enter a password.",
          'forget_password': 'Forget Password',
          "username_password_wrong": "Username or Password wrong",
          "error": "Error",
          "something_went_wrong": "Something went wrong",
          "name_<_5": "Name less than 5 letters",
          'phone_number': 'Phone number',
          'phone_number_example': 'phone number like : : +00 0000000',
          "email_example": 'xx@gmail.com'
        },
        'ar_SA': {
          'hello': 'مرحبا بك',
          //الاعدادات
          'settings': 'الاعدادات',
          'volunteer': 'متطوع',
          'change_language': 'تغيير اللغة',
          'arabic': 'العربية',
          'english': 'الانكليزية',
          'change_password': 'تغيير كلمة المرور',
          'logout': 'تسجيل الخروج',
          'change': 'تغيير',
          'old_password': 'كلمة المرور القديمة',
          'new_password': 'كلمة المرور الجديدة',
          'confirm_new_password': "تأكيد كلمة المرور الجديدة",
          'confirm_logout': 'هل تود تسجيل الخروج من حسابك؟',
          'cancel': "إالغاء الامر",
          'this_field_isEmpty': 'هذا الحقل فارغ',
          "passwords_not_same": "كلمتا السر غير متطابقتين",
          'Edit Profile': 'تعديل الحساب',

          //تسجيل الدخول
          'login': 'تسجيل الدخول',
          'Signup': 'التسجيل',
          'please_login': 'فضلا قم بتسجيل الدخول للاستمرار',
          'please_register': 'فضلا قم بإدخال بياناتك لانشاء الحساب ',
          'phone_number': 'رقم الهاتف',

          'username': 'اسم المستخدم',
          'password': 'كلمة المرور',
          'example': 'مثال: محمد احمد',
          'please_enter_username': "الرجاء ادخال اسم المستخدم",
          'please_enter_password': "الرجاء ادخال كلمة المرور",
          'forget_password': 'لاتتذكر كلمة المرور؟',
          "username_password_wrong": "الاسم أو كلمة السر غير صحيحين",
          "error": "خطأ",
          "something_went_wrong": "هناك شيء خاطئ",
          "name_<_5": "الاسم اقل من 5 احرف",
          'phone_number_example': 'رقم هاتف مثل : +00 00000000',
          "email_example": 'xx@gmail.com',

          //المزامنات
          'synchronizers': 'المزامنات',
          'searh_here': 'ابحث هنا',
          'synchronization': 'مزامنة',
          "home": "الرئيسية",
          "sync": 'مزامنة',
          "no_survies_yet": 'لايوجد لديك استبيانات',

          //home
          'show_all': 'عرض الكل',
          'fill': 'تعبئة',
          'days': 'ايام',
          'since': 'منذ',
          'remaining': 'متبقي',
          'no_result_found': "لاتوجد نتائج",
          "wrong_try_again": "هناك شيء خاطئ,الرجاء المحاولة لاحقا",
          "timeout_try_again": "انتهى الوقت, الرجاء المحاولة لاحقا",

          //جميع الاستمارات
          "all_surveys": "جميع الاستمارات",
          "warning_left_survey":
              "تحذير في حال المغادرة من الاستبيان ستقوم بخسارة الأجوبة",

          //Detail form screen
          "thank_you_sent_successfully":
              "شكرا لك , لقد تم ارسال الاستمارة بنجاح",
          "save_and_sync_later": "حفظ والمزامنة لاحقا",
          "save_and_send_now": "حفظ وارسال الان",
          "thanks_datasaved_synclater":
              "شكرا لك , \n لقد تم حفظ البيانات لاتنسى مزامنتها لاحقاً",
          //تعديل الملف الشخصي
          'edit_account': 'تعديل الملف الشخصي',
          'edit': 'تعديل',
        },
      };
}

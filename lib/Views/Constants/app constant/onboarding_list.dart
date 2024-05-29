import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

List<PageViewModel> onboardingList = [
  PageViewModel(
    titleWidget: const Text(
      "اهلا بكم في تطبيق رحلة",
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w500,
        fontFamily: 'Montserrat',
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.rtl,
    ),
    bodyWidget: const Text(
      "التطبيق المتميز في مجال التنقل والسفر والرحلات",
      style: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w500,
        fontFamily: 'Montserrat',
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.rtl,
    ),
    image: Center(
      child: Image.asset("assets/images/app.png", height: 175.0),
    ),
  ),
  PageViewModel(
    titleWidget: const Text(
      "امكانية التخصيص الكاملة",
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w500,
        fontFamily: 'Montserrat',
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.rtl,
    ),
    bodyWidget: const Text(
      "يمكن لاي شخص اختيار نوع الاستخدام الذي يناسبه اذا كان سائق او مستخدم",
      style: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w500,
        fontFamily: 'Montserrat',
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.rtl,
    ),
    image: Center(
      child: Image.asset("assets/images/peer-to-peer.png", height: 175.0),
    ),
  ),
  PageViewModel(
    titleWidget: const Text(
      "الامان والسرعة",
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w500,
        fontFamily: 'Montserrat',
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.rtl,
    ),
    bodyWidget: const Text(
      "لاستخدام التطبيق في وضع يتطلب انشاء حساب حقيقي عبر التاكيد بواسطة الايميل الشخصي للمستخدم من ثم اخال المعلومات المطلوبة حسب نوع الحساب اذا كان للسائق او المستخدم العادي",
      style: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w500,
        fontFamily: 'Montserrat',
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.rtl,
    ),
    image: Center(
      child: Image.asset("assets/images/quick.png", height: 175.0),
    ),
  ),
  PageViewModel(
    titleWidget: const Text(
      "الفعالية والدقة",
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w500,
        fontFamily: 'Montserrat',
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.rtl,
    ),
    bodyWidget: const Text(
      "تركيز التطبيق على اكمال الرحلات بشكل مبسط وامكانيات عالية بالاضافة الى تسجيل المعلومات ىالضرورية فقط بالنسبة للسائق والمستخدم العادي",
      style: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w500,
        fontFamily: 'Montserrat',
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.rtl,
    ),
    image: Center(
      child: Image.asset("assets/images/project.png", height: 175.0),
    ),
  ),
  PageViewModel(
    titleWidget: const Text(
      "التخصيص الكامل",
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w500,
        fontFamily: 'Montserrat',
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.rtl,
    ),
    bodyWidget: const Text(
      "يمكن لاي مستخدم تبديل نوع اسخدامه للتطبيق في اي وقت بكل سهولة بمجرد تسجيل المعلومات المطلوبة للنوع الجديد",
      style: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w500,
        fontFamily: 'Montserrat',
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.rtl,
    ),
    image: Center(
      child: Image.asset("assets/images/interactions.png", height: 175.0),
    ),
  ),
  PageViewModel(
    titleWidget: const Text(
      "البحث المخصص",
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w500,
        fontFamily: 'Montserrat',
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.rtl,
    ),
    bodyWidget: const Text(
      "البحث عن الرحلات التي تناسب المسخدم عبر البحث عبر تحديد البعد عن السائقين المتاحين او البعد عن الوجه المحددة والمقارنة بين الاسعار واختيار الرحلة الانسب للمستخدم",
      style: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w500,
        fontFamily: 'Montserrat',
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.rtl,
    ),
    image: Center(
      child: Image.asset("assets/images/search.png", height: 175.0),
    ),
  ),
  PageViewModel(
    titleWidget: const Text(
      "ادارة الطلبات ",
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w500,
        fontFamily: 'Montserrat',
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.rtl,
    ),
    bodyWidget: const Text(
      "يمكن للمستخدم بعد اختيار الرحلة المناسبة ارسال الطلبات بكل سهولة للسائقين ومتابعة الطلبات الخاصة به اذا تمت الموافقة عليها ام لا",
      style: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w500,
        fontFamily: 'Montserrat',
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.rtl,
    ),
    image: Center(
      child: Image.asset("assets/images/clipboard.png", height: 175.0),
    ),
  ),
  PageViewModel(
    titleWidget: const Text(
      "التكلفة المنخفضة ",
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w500,
        fontFamily: 'Montserrat',
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.rtl,
    ),
    bodyWidget: const Text(
      "يعتمد التطبيق بشكل اساسي على  خدمات الموقع  المجانية وعند الحاجة الى الوصول الى الهدف عل  الخريطة يمكن الانتقال الى خراط كوكل بشكل مباشر",
      style: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w500,
        fontFamily: 'Montserrat',
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.rtl,
    ),
    image: Center(
      child: Image.asset("assets/images/price-tag.png", height: 175.0),
    ),
  ),
  PageViewModel(
    titleWidget: const Text(
      "الواجهات الرائعة",
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w500,
        fontFamily: 'Montserrat',
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.rtl,
    ),
    bodyWidget: const Text(
      "تم اعداد الوجهات باسلوب عصري ومميز وباستخدام احدث التقنيات والتصاميم الحديثة",
      style: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w500,
        fontFamily: 'Montserrat',
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.rtl,
    ),
    image: Center(
      child: Image.asset("assets/images/ux-design.png", height: 175.0),
    ),
  ),
  PageViewModel(
    titleWidget: const Text(
      "ماذا تنتظر؟",
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w500,
        fontFamily: 'Montserrat',
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.rtl,
    ),
    bodyWidget: const Text(
      " ابدأ الان واستمتع بالتجربة الرائعة مع تطبيق رحلة",
      style: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w500,
        fontFamily: 'Montserrat',
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.rtl,
    ),
    image: Center(
      child: Image.asset("assets/images/victory.png", height: 175.0),
    ),
  ),
];

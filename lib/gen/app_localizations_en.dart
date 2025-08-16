// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get login => 'Giriş Yap';

  @override
  String get logout => 'Çıkış Yap';

  @override
  String get loginHello => 'Merhabalar';

  @override
  String get loginDescription => 'Zamanın değişkenliği, hayatın zaman zaman acı verici unsurlarını \nve iki yönlü zorlukları da beraberinde getirir.';

  @override
  String get email => 'E-posta';

  @override
  String get password => 'Şifre';

  @override
  String get loginForgotPassword => 'Şifremi unuttum';

  @override
  String get noAccount => 'Bir hesabınız yok mu?';

  @override
  String get noAccountSignUp => 'Kayıt ol!';

  @override
  String get signUp => 'Kayıt ol';

  @override
  String welcomeMessage(String userName) {
    return 'Welcome, $userName';
  }

  @override
  String remainingApples(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count apples left.',
      one: '1 apple left.',
      zero: 'No apples left.',
    );
    return '$_temp0';
  }
}

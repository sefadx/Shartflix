// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get login => 'Giriş Yap';

  @override
  String get signUp => 'Kayıt Ol';

  @override
  String get signUpRightNow => 'Şimdi Kaydol';

  @override
  String get logout => 'Çıkış Yap';

  @override
  String get warning => 'Uyarı';

  @override
  String get error => 'Hata';

  @override
  String get unknown => 'Bilinmeyen';

  @override
  String get unknownError => 'Bilinmeyen Hata';

  @override
  String get loginHello => 'Merhabalar';

  @override
  String get loginDescription => 'Zamanın değişkenliği, hayatın zaman zaman acı verici unsurlarını \nve iki yönlü zorlukları da beraberinde getirir.';

  @override
  String get loginForgotPassword => 'Şifremi unuttum';

  @override
  String get fullNameValid => 'Lütfen geçerli ad girin. Minimum 4 karakter.';

  @override
  String get emailValid => 'Lütfen geçerli email giriniz.';

  @override
  String get passwordValid => 'Lütfen şifrenizi kontrol edin. Minimum 6 karakter.';

  @override
  String get rePasswordCheck => 'Lütfen şifrenizin şifre tekrarı  ile aynı olduğundan emin olun.';

  @override
  String get agreementCheck => 'Kullanıcı Sözleşmesini okuyunuz.';

  @override
  String get userAgreement => 'Kullanıcı sözleşmesini okudum ve kabul ediyorum.';

  @override
  String get userAgreementPart1 => 'Kullanıcı sözleşmesini ';

  @override
  String get userAgreementPart2 => 'okudum ve kabul ediyorum.';

  @override
  String get pleaseReadAgreement => 'Bu sözleşmeyi okuyarak devam ediniz lütfen.';

  @override
  String get fullName => 'Ad Soyad';

  @override
  String get email => 'E-posta';

  @override
  String get password => 'Şifre';

  @override
  String get rePassword => 'Şifre Tekrarı';

  @override
  String get noAccount => 'Bir hesabınız yok mu?';

  @override
  String get noAccountSignUp => 'Kayıt ol!';

  @override
  String get alreadyHaveAccount => 'Zaten bir hesabın var mı ?';

  @override
  String get alreadyHaveAccountLogIn => 'Giriş yap!';

  @override
  String welcomeMessage(String userName) {
    return 'Hoş geldin, $userName';
  }

  @override
  String remainingApples(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count elma kaldı.',
      one: '1 elma kaldı.',
      zero: 'Hiç elma kalmadı.',
    );
    return '$_temp0';
  }
}

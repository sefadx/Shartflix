// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get homePage => 'Anasayfa';

  @override
  String get profile => 'Profil';

  @override
  String get profileDetail => 'Profil Detayı';

  @override
  String get likedYourMovies => 'Beğendiğin Filmler';

  @override
  String get success => 'Başarılı';

  @override
  String get failure => 'Başarısız';

  @override
  String get uploadYourPhotos => 'Fotoğraflarınızı Yükleyin';

  @override
  String get uploadYourPhotosDesc => 'Önce fotoğrafını seç, sonra onu yükle';

  @override
  String get uploaded => 'Yükleme Tamamlandı';

  @override
  String get perWeek => 'Başına Haftalık';

  @override
  String get token => 'Jeton';

  @override
  String get limitedOffer => 'Sınırlı Teklif';

  @override
  String get offerDescription => 'Jeton paketini seçerek bonus\nkazanın ve yeni bölümlerin kilidini açın.';

  @override
  String get incomeBonuses => 'Alacağınız Bonuslar';

  @override
  String get premiumAccount => 'Premium\nHesap';

  @override
  String get moreMatch => 'Daha\nFazla Eşleşme';

  @override
  String get morePriority => 'Öne\nÇıkarma';

  @override
  String get moreLike => 'Daha\nFazla Beğeni';

  @override
  String get selectTokenOffer => 'Kilidi açmak için bir jeton pakedi seçin';

  @override
  String get seeAllTokens => 'Tüm Jetonları Gör';

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
  String get addPhoto => 'Fotoğraf Ekle';

  @override
  String get actionFavorite => 'Favoriye alındı';

  @override
  String get actionUnfavored => 'Favoriden çıkarıldı';

  @override
  String price(String value) {
    return '$value';
  }

  @override
  String percentDiscount(String value) {
    return '%$value';
  }

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

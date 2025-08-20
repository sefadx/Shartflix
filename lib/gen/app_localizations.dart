import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_tr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('tr')
  ];

  /// No description provided for @homePage.
  ///
  /// In tr, this message translates to:
  /// **'Anasayfa'**
  String get homePage;

  /// No description provided for @profile.
  ///
  /// In tr, this message translates to:
  /// **'Profil'**
  String get profile;

  /// No description provided for @profileDetail.
  ///
  /// In tr, this message translates to:
  /// **'Profil Detayı'**
  String get profileDetail;

  /// No description provided for @likedYourMovies.
  ///
  /// In tr, this message translates to:
  /// **'Beğendiğin Filmler'**
  String get likedYourMovies;

  /// No description provided for @success.
  ///
  /// In tr, this message translates to:
  /// **'Başarılı'**
  String get success;

  /// No description provided for @failure.
  ///
  /// In tr, this message translates to:
  /// **'Başarısız'**
  String get failure;

  /// No description provided for @uploadYourPhotos.
  ///
  /// In tr, this message translates to:
  /// **'Fotoğraflarınızı Yükleyin'**
  String get uploadYourPhotos;

  /// No description provided for @uploadYourPhotosDesc.
  ///
  /// In tr, this message translates to:
  /// **'Önce fotoğrafını seç, sonra onu yükle'**
  String get uploadYourPhotosDesc;

  /// No description provided for @uploaded.
  ///
  /// In tr, this message translates to:
  /// **'Yükleme Tamamlandı'**
  String get uploaded;

  /// No description provided for @perWeek.
  ///
  /// In tr, this message translates to:
  /// **'Başına Haftalık'**
  String get perWeek;

  /// No description provided for @token.
  ///
  /// In tr, this message translates to:
  /// **'Jeton'**
  String get token;

  /// No description provided for @limitedOffer.
  ///
  /// In tr, this message translates to:
  /// **'Sınırlı Teklif'**
  String get limitedOffer;

  /// No description provided for @offerDescription.
  ///
  /// In tr, this message translates to:
  /// **'Jeton paketini seçerek bonus\nkazanın ve yeni bölümlerin kilidini açın.'**
  String get offerDescription;

  /// No description provided for @incomeBonuses.
  ///
  /// In tr, this message translates to:
  /// **'Alacağınız Bonuslar'**
  String get incomeBonuses;

  /// No description provided for @premiumAccount.
  ///
  /// In tr, this message translates to:
  /// **'Premium\nHesap'**
  String get premiumAccount;

  /// No description provided for @moreMatch.
  ///
  /// In tr, this message translates to:
  /// **'Daha\nFazla Eşleşme'**
  String get moreMatch;

  /// No description provided for @morePriority.
  ///
  /// In tr, this message translates to:
  /// **'Öne\nÇıkarma'**
  String get morePriority;

  /// No description provided for @moreLike.
  ///
  /// In tr, this message translates to:
  /// **'Daha\nFazla Beğeni'**
  String get moreLike;

  /// No description provided for @selectTokenOffer.
  ///
  /// In tr, this message translates to:
  /// **'Kilidi açmak için bir jeton pakedi seçin'**
  String get selectTokenOffer;

  /// No description provided for @seeAllTokens.
  ///
  /// In tr, this message translates to:
  /// **'Tüm Jetonları Gör'**
  String get seeAllTokens;

  /// No description provided for @login.
  ///
  /// In tr, this message translates to:
  /// **'Giriş Yap'**
  String get login;

  /// No description provided for @signUp.
  ///
  /// In tr, this message translates to:
  /// **'Kayıt Ol'**
  String get signUp;

  /// No description provided for @signUpRightNow.
  ///
  /// In tr, this message translates to:
  /// **'Şimdi Kaydol'**
  String get signUpRightNow;

  /// No description provided for @logout.
  ///
  /// In tr, this message translates to:
  /// **'Çıkış Yap'**
  String get logout;

  /// No description provided for @warning.
  ///
  /// In tr, this message translates to:
  /// **'Uyarı'**
  String get warning;

  /// No description provided for @error.
  ///
  /// In tr, this message translates to:
  /// **'Hata'**
  String get error;

  /// No description provided for @unknown.
  ///
  /// In tr, this message translates to:
  /// **'Bilinmeyen'**
  String get unknown;

  /// No description provided for @unknownError.
  ///
  /// In tr, this message translates to:
  /// **'Bilinmeyen Hata'**
  String get unknownError;

  /// No description provided for @loginHello.
  ///
  /// In tr, this message translates to:
  /// **'Merhabalar'**
  String get loginHello;

  /// No description provided for @loginDescription.
  ///
  /// In tr, this message translates to:
  /// **'Zamanın değişkenliği, hayatın zaman zaman acı verici unsurlarını \nve iki yönlü zorlukları da beraberinde getirir.'**
  String get loginDescription;

  /// No description provided for @loginForgotPassword.
  ///
  /// In tr, this message translates to:
  /// **'Şifremi unuttum'**
  String get loginForgotPassword;

  /// No description provided for @fullNameValid.
  ///
  /// In tr, this message translates to:
  /// **'Lütfen geçerli ad girin. Minimum 4 karakter.'**
  String get fullNameValid;

  /// No description provided for @emailValid.
  ///
  /// In tr, this message translates to:
  /// **'Lütfen geçerli email giriniz.'**
  String get emailValid;

  /// No description provided for @passwordValid.
  ///
  /// In tr, this message translates to:
  /// **'Lütfen şifrenizi kontrol edin. Minimum 6 karakter.'**
  String get passwordValid;

  /// No description provided for @rePasswordCheck.
  ///
  /// In tr, this message translates to:
  /// **'Lütfen şifrenizin şifre tekrarı  ile aynı olduğundan emin olun.'**
  String get rePasswordCheck;

  /// No description provided for @agreementCheck.
  ///
  /// In tr, this message translates to:
  /// **'Kullanıcı Sözleşmesini okuyunuz.'**
  String get agreementCheck;

  /// Kullanıcı sözleşmesi onayı
  ///
  /// In tr, this message translates to:
  /// **'Kullanıcı sözleşmesini okudum ve kabul ediyorum.'**
  String get userAgreement;

  /// No description provided for @userAgreementPart1.
  ///
  /// In tr, this message translates to:
  /// **'Kullanıcı sözleşmesini '**
  String get userAgreementPart1;

  /// No description provided for @userAgreementPart2.
  ///
  /// In tr, this message translates to:
  /// **'okudum ve kabul ediyorum.'**
  String get userAgreementPart2;

  /// No description provided for @pleaseReadAgreement.
  ///
  /// In tr, this message translates to:
  /// **'Bu sözleşmeyi okuyarak devam ediniz lütfen.'**
  String get pleaseReadAgreement;

  /// No description provided for @fullName.
  ///
  /// In tr, this message translates to:
  /// **'Ad Soyad'**
  String get fullName;

  /// No description provided for @email.
  ///
  /// In tr, this message translates to:
  /// **'E-posta'**
  String get email;

  /// No description provided for @password.
  ///
  /// In tr, this message translates to:
  /// **'Şifre'**
  String get password;

  /// No description provided for @rePassword.
  ///
  /// In tr, this message translates to:
  /// **'Şifre Tekrarı'**
  String get rePassword;

  /// No description provided for @noAccount.
  ///
  /// In tr, this message translates to:
  /// **'Bir hesabınız yok mu?'**
  String get noAccount;

  /// No description provided for @noAccountSignUp.
  ///
  /// In tr, this message translates to:
  /// **'Kayıt ol!'**
  String get noAccountSignUp;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In tr, this message translates to:
  /// **'Zaten bir hesabın var mı ?'**
  String get alreadyHaveAccount;

  /// No description provided for @alreadyHaveAccountLogIn.
  ///
  /// In tr, this message translates to:
  /// **'Giriş yap!'**
  String get alreadyHaveAccountLogIn;

  /// No description provided for @addPhoto.
  ///
  /// In tr, this message translates to:
  /// **'Fotoğraf Ekle'**
  String get addPhoto;

  /// No description provided for @actionFavorite.
  ///
  /// In tr, this message translates to:
  /// **'Favoriye alındı'**
  String get actionFavorite;

  /// No description provided for @actionUnfavored.
  ///
  /// In tr, this message translates to:
  /// **'Favoriden çıkarıldı'**
  String get actionUnfavored;

  /// Ülke para formatında fiyat
  ///
  /// In tr, this message translates to:
  /// **'{value}'**
  String price(String value);

  /// İndirim yüzdesini gösterir, % işareti başta (Türkçe)
  ///
  /// In tr, this message translates to:
  /// **'%{value}'**
  String percentDiscount(String value);

  /// Kullanıcıyı ana ekranda karşılayan mesaj
  ///
  /// In tr, this message translates to:
  /// **'Hoş geldin, {userName}'**
  String welcomeMessage(String userName);

  /// Kalan elma sayısını gösteren çoğul mesaj
  ///
  /// In tr, this message translates to:
  /// **'{count, plural, zero{Hiç elma kalmadı.} one{1 elma kaldı.} other{{count} elma kaldı.}}'**
  String remainingApples(int count);
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'tr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'tr': return AppLocalizationsTr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}

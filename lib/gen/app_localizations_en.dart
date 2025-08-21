// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get homePage => 'Homepage';

  @override
  String get profile => 'Profile';

  @override
  String get profileDetail => 'Profile Details';

  @override
  String get likedYourMovies => 'Favorite Films';

  @override
  String get success => 'Success';

  @override
  String get failure => 'Failure';

  @override
  String get uploadYourPhotos => 'Upload Your Photos';

  @override
  String get uploadYourPhotosDesc => 'Before pick your photo, after upload it';

  @override
  String get uploaded => 'Uploaded';

  @override
  String get perWeek => 'Per Week';

  @override
  String get token => 'Jeton';

  @override
  String get limitedOffer => 'Limited Offer';

  @override
  String get offerDescription => 'Select a token package\nto earn bonusesand unlock new levels.';

  @override
  String get incomeBonuses => 'Earn Bonuses';

  @override
  String get premiumAccount => 'Premium\nAccount';

  @override
  String get moreMatch => 'More\natches';

  @override
  String get morePriority => 'Highlight\n';

  @override
  String get moreLike => 'More\nLikes';

  @override
  String get selectTokenOffer => 'Select a token offer to unlock';

  @override
  String get seeAllTokens => 'Show All Tokens';

  @override
  String get login => 'Login';

  @override
  String get signUp => 'Sign Up';

  @override
  String get signUpRightNow => 'Sign Up Now';

  @override
  String get logout => 'Logout';

  @override
  String get warning => 'Warning';

  @override
  String get error => 'Error';

  @override
  String get unknown => 'Unknown';

  @override
  String get unknownError => 'Unknown Error';

  @override
  String get loginHello => 'Hello';

  @override
  String get loginDescription => 'The variability of time also brings along the painful aspects of life \nand its dual difficulties.';

  @override
  String get loginForgotPassword => 'Forgot Password';

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
  String get userAgreement => 'I have read and agree to the User Agreement.';

  @override
  String get userAgreementPart1 => 'I have read and agree to the ';

  @override
  String get userAgreementPart2 => 'User Agreement.';

  @override
  String get pleaseReadAgreement => 'Please continue by reading this agreement.';

  @override
  String get fullName => 'Full Name';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get rePassword => 'Repeat Password';

  @override
  String get noAccount => 'Don\'t have an account?';

  @override
  String get noAccountSignUp => 'Sign up!';

  @override
  String get alreadyHaveAccount => 'Already have an account?';

  @override
  String get alreadyHaveAccountLogIn => 'Log in!';

  @override
  String get addPhoto => 'Upload Photo';

  @override
  String get actionFavorite => 'Added favorites';

  @override
  String get actionUnfavored => 'Removed from favorites';

  @override
  String price(String value) {
    return '$value';
  }

  @override
  String percentDiscount(String value) {
    return '$value%';
  }

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

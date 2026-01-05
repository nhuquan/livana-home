import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_vi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
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
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('vi')
  ];

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @ourServices.
  ///
  /// In en, this message translates to:
  /// **'Our Services'**
  String get ourServices;

  /// No description provided for @ourWork.
  ///
  /// In en, this message translates to:
  /// **'Our Work'**
  String get ourWork;

  /// No description provided for @workWithUs.
  ///
  /// In en, this message translates to:
  /// **'Work With Us'**
  String get workWithUs;

  /// No description provided for @homeSlogan.
  ///
  /// In en, this message translates to:
  /// **'Where innovation serves humanity.'**
  String get homeSlogan;

  /// No description provided for @homeValues.
  ///
  /// In en, this message translates to:
  /// **'The Buddha taught that real success comes from earning your living honestly, peacefully, and without harming others.\n\nAt Livana Software, we understand that in the modern world, technology is often driven by money. While money is important, it should not be the only motivation. Hence, we have deliberately chosen to focus our time and energy on building things that truly matter. Our aim is to create products and services that have a meaningful and positive impact on both people\'s lives and the society. We believe that real value is created from good deeds and we are rewarded enough simply by doing them.'**
  String get homeValues;

  /// No description provided for @chatWithUs.
  ///
  /// In en, this message translates to:
  /// **'Chat with us'**
  String get chatWithUs;

  /// No description provided for @contactNumberSnackBar.
  ///
  /// In en, this message translates to:
  /// **'SMS / Zalo / Whatsapp: (+84) 981-682-904'**
  String get contactNumberSnackBar;

  /// No description provided for @servicesDescription.
  ///
  /// In en, this message translates to:
  /// **'Livana is a full-service software company that helps companies to face the challenge in their digital transformation journey. Our expertise is in working directly with our client as an extension of their team to support rapid growth and help bring projects to life.'**
  String get servicesDescription;

  /// No description provided for @serviceSoftwareDelivery.
  ///
  /// In en, this message translates to:
  /// **'Software delivery'**
  String get serviceSoftwareDelivery;

  /// No description provided for @serviceMobile.
  ///
  /// In en, this message translates to:
  /// **'Mobile'**
  String get serviceMobile;

  /// No description provided for @serviceWeb.
  ///
  /// In en, this message translates to:
  /// **'Web'**
  String get serviceWeb;

  /// No description provided for @serviceBackend.
  ///
  /// In en, this message translates to:
  /// **'Backend systems'**
  String get serviceBackend;

  /// No description provided for @serviceGame.
  ///
  /// In en, this message translates to:
  /// **'Game'**
  String get serviceGame;

  /// No description provided for @serviceTeamAugmentation.
  ///
  /// In en, this message translates to:
  /// **'Team augmentation'**
  String get serviceTeamAugmentation;

  /// No description provided for @serviceTechLead.
  ///
  /// In en, this message translates to:
  /// **'Tech-lead'**
  String get serviceTechLead;

  /// No description provided for @serviceFullstack.
  ///
  /// In en, this message translates to:
  /// **'Fullstack engineer'**
  String get serviceFullstack;

  /// No description provided for @serviceQA.
  ///
  /// In en, this message translates to:
  /// **'QA'**
  String get serviceQA;

  /// No description provided for @serviceUXUI.
  ///
  /// In en, this message translates to:
  /// **'UX/UI'**
  String get serviceUXUI;

  /// No description provided for @serviceConsultant.
  ///
  /// In en, this message translates to:
  /// **'Consultant'**
  String get serviceConsultant;

  /// No description provided for @serviceTraining.
  ///
  /// In en, this message translates to:
  /// **'Training'**
  String get serviceTraining;

  /// No description provided for @serviceAdhocSupport.
  ///
  /// In en, this message translates to:
  /// **'Adhoc support'**
  String get serviceAdhocSupport;

  /// No description provided for @serviceOnDemand.
  ///
  /// In en, this message translates to:
  /// **'On demand session'**
  String get serviceOnDemand;

  /// No description provided for @projectGarageDesc.
  ///
  /// In en, this message translates to:
  /// **'Smart garage maintenance and vehicle tracking.'**
  String get projectGarageDesc;

  /// No description provided for @projectFocusTrackerDesc.
  ///
  /// In en, this message translates to:
  /// **'Track your focus time and build productive habits.'**
  String get projectFocusTrackerDesc;

  /// No description provided for @projectEngagedBuddhismDesc.
  ///
  /// In en, this message translates to:
  /// **'Buddhist teachings from Zen Master Thich Nhat Hanh'**
  String get projectEngagedBuddhismDesc;

  /// No description provided for @projectMoonCalendarDesc.
  ///
  /// In en, this message translates to:
  /// **'Track moon phases and connect with lunar cycles.'**
  String get projectMoonCalendarDesc;

  /// No description provided for @projectDailyWisdomDesc.
  ///
  /// In en, this message translates to:
  /// **'Daily inspirational quotes to brighten your day.'**
  String get projectDailyWisdomDesc;

  /// No description provided for @projectSoundGroundDesc.
  ///
  /// In en, this message translates to:
  /// **'Relax and focus with ambient sounds.'**
  String get projectSoundGroundDesc;

  /// No description provided for @projectFlappyDesc.
  ///
  /// In en, this message translates to:
  /// **'A fun and addictive game to challenge your friends.'**
  String get projectFlappyDesc;

  /// No description provided for @projectStarHunterDesc.
  ///
  /// In en, this message translates to:
  /// **'Explore the universe and hunt for stars.'**
  String get projectStarHunterDesc;

  /// No description provided for @projectMaiDesc.
  ///
  /// In en, this message translates to:
  /// **'Your personal AI companion for mental wellness.'**
  String get projectMaiDesc;

  /// No description provided for @letsBuildSomething.
  ///
  /// In en, this message translates to:
  /// **'Let\'s build something beautiful.'**
  String get letsBuildSomething;

  /// No description provided for @contactUsButton.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contactUsButton;

  /// No description provided for @contactFormDescription.
  ///
  /// In en, this message translates to:
  /// **'Please use the form below to request a quote for a project, inquire about a collaboration, or simply say hello.'**
  String get contactFormDescription;

  /// No description provided for @nameRequired.
  ///
  /// In en, this message translates to:
  /// **'Name (required)'**
  String get nameRequired;

  /// No description provided for @yourName.
  ///
  /// In en, this message translates to:
  /// **'Your Name'**
  String get yourName;

  /// No description provided for @enterNameError.
  ///
  /// In en, this message translates to:
  /// **'Please enter your name.'**
  String get enterNameError;

  /// No description provided for @emailRequired.
  ///
  /// In en, this message translates to:
  /// **'Email (required)'**
  String get emailRequired;

  /// No description provided for @enterEmailError.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email.'**
  String get enterEmailError;

  /// No description provided for @enterValidEmailError.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address.'**
  String get enterValidEmailError;

  /// No description provided for @messageRequired.
  ///
  /// In en, this message translates to:
  /// **'Message (required)'**
  String get messageRequired;

  /// No description provided for @enterMessageError.
  ///
  /// In en, this message translates to:
  /// **'Please enter your message.'**
  String get enterMessageError;

  /// No description provided for @submitButton.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submitButton;

  /// No description provided for @submittingMessage.
  ///
  /// In en, this message translates to:
  /// **'Submitting...'**
  String get submittingMessage;

  /// No description provided for @successMessage.
  ///
  /// In en, this message translates to:
  /// **'Thank you! Your message has been received.'**
  String get successMessage;

  /// No description provided for @errorMessage.
  ///
  /// In en, this message translates to:
  /// **'An error occurred. Please check your connection and try again.'**
  String get errorMessage;

  /// No description provided for @submissionInProgress.
  ///
  /// In en, this message translates to:
  /// **'Submission in progress...'**
  String get submissionInProgress;

  /// No description provided for @formError.
  ///
  /// In en, this message translates to:
  /// **'Please correct the errors in the form.'**
  String get formError;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'vi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'vi':
      return AppLocalizationsVi();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}

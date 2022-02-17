import 'dart:ui';

//NETWORK
const String kProtocol = 'http';
const String kBaseUrl = '192.168.3.153:1001';
const String kProxyUrl = '192.168.3.153:8000';
const bool kNetworkLog = false;
const bool kProxy = true;
const int kNetworkConnectTimeout = 60000;
const int kNetworkReceiveTimeout = 60000;

//ROUTE NAME
const String kIntroPage = '/';
const String kLandingPage = '/landing';
const String kLoginPage = '/login';
const String kForgotPasswordPage = '/forgot_password';
const String kOtpPage = '/otp';
const String kRegisterPage = '/register';
const String kPhonePage = '/phone';
const String kAppPage = '/app';
const String kSearchPage = '/search';
const String kProductDetailPage = '/product_detail';
const String kProductPage = '/product';
const String kCheckoutPage = '/checkout';
const String kOrderCompletePage = '/order_complete';
const String kDeliveryAddressPage = '/delivery_address';
const String kVoucherPage = '/voucher';
const String kOrderDetailPage = '/order_detail';
const String kChatDetailPage = '/chat_detail';
const String kTrackingPage = '/tracking';

//REST API
const String kAuthAccess = 'customer/auth/access';
const String kAuthRegister = 'customer/auth/register';
const String kAuthRevoke = 'customer/auth/revoke';
const String kShowCustomerAccount = 'customer/user';
const String kUpdateFcm = 'customer/user/fcm';
const String kCategoryIndex = 'customer/categories';
const String kBannerIndex = 'customer/banners';
const String kProductIndex = 'customer/products';
const String kProductShow = 'customer/products';
const String kProductViewHistory = 'customer/products/histories';
const String kProductFavourite = 'customer/products/favourite';
const String kProductStatistic = 'customer/products/statistic';
const String kBundleIndex = 'customer/bundles';
const String kSearchIndex = 'customer/searches';
const String kSearchSuggestion = 'customer/searches/suggestions';
const String kSearchStore = 'customer/searches';
const String kSearchDelete = 'customer/searches';
const String kCartIndex = 'customer/carts';
const String kCartUpdate = 'customer/carts';
const String kCartClear = 'customer/carts';

//ASSETS
const String kGoceryLogo = 'asset/image/ui/gocery_logo_clean.svg';
const String kGoceryLogoTop = 'asset/image/ui/gocery_logo_top_clean.svg';
const String kGoceryLogoSide = 'asset/image/ui/gocery_logo_side_clean.svg';
const String kFacebookLogo = 'asset/image/ui/facebook_clean.svg';
const String kGoogleLogo = 'asset/image/ui/google_clean.svg';
const String kCoinIcon = 'asset/image/ui/coin.svg';
const String kEmptyCart = 'asset/image/ui/empty_cart_small.svg';
const String kOrderComplete = 'asset/image/ui/complete_clean.svg';
const String kScrollTopButtonIcon = 'asset/image/ui/up.svg';
const String kLandingOne = 'asset/image/content/landing_one.svg';
const String kLandingTwo = 'asset/image/content/landing_two.svg';

//UI
const Color kPrimaryColor = Color(0xff64BA02);
const Color kPrimaryColor50 = Color(0xffF9FFF3);
const Color kPrimaryColor100 = Color(0xffF7FFEF);
const Color kPrimaryColor200 = Color(0xffE9F6DB);
const Color kPrimaryColor300 = Color(0xffB0F363);
const Color kPrimaryColor400 = Color(0xff7FDA17);
const Color kPrimaryColor500 = kPrimaryColor;
const Color kPrimaryColor600 = Color(0xff509600);
const Color kPrimaryColor700 = Color(0xff407700);
const Color kPrimaryColor800 = Color(0xff2B5000);
const Color kPrimaryColor900 = Color(0xff172B00);
const Color kBackgroundColor = Color(0xffF2F2F2);
const Color kLightColor = Color(0xffFFFFFF);
const Color kLightColor50 = Color(0xffEBF0F9);
const Color kLightColor100 = Color(0xff8F9BB3);
const Color kDarkColor = Color(0xff222B45);
const Color kErrorColor = Color(0xffF44336);
const Color kAccentColor = Color(0xff0095FF);
const double kTinyPadding = 8;
const double kSmallPadding = 10;
const double kMediumPadding = 14;
const double kBigPadding = 18;
const double kLargePadding = 24;
const double kHugePadding = 30;
const double kTinyFont = 10;
const double kSmallFont = 12;
const double kMediumFont = 16;
const double kBigFont = 20;
const double kLargeFont = 24;
const double kHugeFont = 30;

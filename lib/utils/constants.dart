import 'dart:ui';

bool gIsDarkMode = false;
String gUserAgent = "";

enum IdVerificationType { none, nid, passport, driving, voter }

enum PhotoType { front, back, selfie }

class AssetConstants {
  //ICONS
  static const basePathIcons = "assets/icons/";
  static const icLogo = "${basePathIcons}icLogo.svg";
  static const icLogoWithTitle = "${basePathIcons}icLogoWithTitle.svg";
  static const icBottomBgMark = "${basePathIcons}icBottomBgMark.svg";
  static const icBottomBgMarkDark = "${basePathIcons}icBottomBgMarkDark.svg";
  static const icBottomBgAuth = "${basePathIcons}icBottomBgAuth.svg";
  static const icTopBgMark = "${basePathIcons}icTopBgMark.svg";
  static const icEllipseBg = "${basePathIcons}icEllipseBg.svg";
  static const icEmail = "${basePathIcons}ic_email.svg";
  static const icFingerprintScan = "${basePathIcons}ic_fingerprint_scan.svg";
  static const icKey = "${basePathIcons}ic_key.svg";
  static const icSmartphone = "${basePathIcons}ic_smartphone.svg";
  static const icUpload = "${basePathIcons}ic_upload.svg";
  static const icRibbon = "${basePathIcons}ic_ribbon.png";
  static const icInfoCircle = "${basePathIcons}ic_info_circle.svg";
  static const icMessage = "${basePathIcons}ic_message.svg";

  ///IMAGES
  static const basePathImages = "assets/images/";
  static const emptyCart = "${basePathImages}clipboard.png";
  static const logo = "${basePathImages}foodu.png";
  static const papalLogo = "${basePathImages}PayPal.png";
  static const CODPayment = "${basePathImages}COD.png";

  // ANIMATIONS
  static const basePathAnimation = "assets/animations/";
  static const animationTick = "${basePathAnimation}tick.json";

  //////////
  static const pathTempImageFolder = "/tmpImages/";
  static const pathTempFrontImageName = "_frontImage_id_verify.jpeg";
  static const pathTempBackImageName = "_backImage_id_verify.jpeg";

  static const avatar = "${basePathImages}avatar.png";
  static const noImage = "${basePathImages}noImage.png";
  static const imgNotAvailable = "${basePathImages}imageNotAvailable.png";

  static const bgScreen = "${basePathImages}bgScreen.png";
  static const bgAuth = "${basePathImages}bgAuth.png";
  static const bgAuthTop = "${basePathImages}bgAuthTop.png";
  static const bgAuthMiddle = "${basePathImages}bgAuthMiddle.png";
  static const bgAuthMiddleDark = "${basePathImages}bgAuthMiddleDark.png";
  static const bgAuthBottomLeft = "${basePathImages}bgAuthBottomLeft.png";
  static const bgAppBar = "${basePathImages}bgAppBar.png";
  static const bgAppBar2 = "${basePathImages}bgAppBar2.png";
  static const bg = "${basePathImages}bg.png";
  static const bg2 = "${basePathImages}bg2.png";
  static const bgNavHeader = "${basePathImages}bgNavHeader.png";
  static const qr = "${basePathImages}qr.png";
  static const btcChart = "${basePathImages}btcChart.png";
  static const learn = "${basePathImages}learn.png";

  static const bgOnBoarding = "${basePathImages}bgOnBoarding.png";
  static const onBoarding0 = "${basePathImages}onBoarding0.png";
  static const onBoarding1 = "${basePathImages}onBoarding1.png";
  static const onBoarding2 = "${basePathImages}onBoarding2.png";

  static const icGoogleAuthenticatorLogo =
      "${basePathImages}icGoogleAuthenticatorLogo.png";
  static const icEmptyDataPng = "${basePathImages}icEmptyDataPng.png";
  static const chartOverview = "${basePathImages}chartOverview.png";

  static const icArrowLeft = "${basePathIcons}ic_arrow_left.svg";
  static const icArrowRight = "${basePathIcons}ic_arrow_right.svg";
  static const icArrowDown = "${basePathIcons}ic_arrow_down.svg";
  static const icCloseBox = "${basePathIcons}ic_close_box.svg";
  static const icPasswordHide = "${basePathIcons}ic_password_hide.svg";
  static const icPasswordShow = "${basePathIcons}ic_password_show.svg";
  static const icBoxSquare = "${basePathIcons}ic_box_square.svg";
  static const icTickRound = "${basePathIcons}ic_tick_round.svg";
  static const icTickSquare = "${basePathIcons}ic_tick_square.svg";
  static const icTickLarge = "${basePathIcons}icTickLarge.svg";
  static const icTime = "${basePathIcons}icTime.svg";
  static const icBoxFilterAll = "${basePathIcons}icBoxFilterAll.svg";
  static const icBoxFilterSell = "${basePathIcons}icBoxFilterSell.svg";
  static const icBoxFilterBuy = "${basePathIcons}icBoxFilterBuy.svg";
  static const icCrossIsolated = "${basePathIcons}icCrossIsolated.svg";
  static const icAccentDot = "${basePathIcons}icAccentDot.svg";

  static const icCamera = "${basePathIcons}ic_camera.svg";
  static const icNotification = "${basePathIcons}icNotification.svg";
  static const icMenu = "${basePathIcons}icMenu.svg";
  static const icDashboard = "${basePathIcons}icDashboard.svg";
  static const icActivity = "${basePathIcons}icActivity.svg";
  static const icWallet = "${basePathIcons}icWallet.svg";
  static const icMarket = "${basePathIcons}icMarket.svg";

  static const icNavActivity = "${basePathIcons}icNavActivity.svg";
  static const icNavLogout = "${basePathIcons}icNavLogout.svg";
  static const icNavPersonalVerification =
      "${basePathIcons}icNavPersonalVerification.svg";
  static const icNavProfile = "${basePathIcons}icNavProfile.svg";
  static const icNavReferrals = "${basePathIcons}icNavReferrals.svg";
  static const icNavResetPassword = "${basePathIcons}icNavResetPassword.svg";
  static const icNavSecurity = "${basePathIcons}icNavSecurity.svg";
  static const icNavSettings = "${basePathIcons}icNavSettings.svg";

  static const icHomeTabSelected = "${basePathIcons}ic_home_tab_selected.svg";
  static const icExplore = "${basePathIcons}ic_explore.svg";
  static const icExploreTabSelected =
      "${basePathIcons}ic_explore_tab_selected.svg";
  static const icFavorite = "${basePathIcons}ic_favorite.svg";
  static const icFavoriteTabSelected =
      "${basePathIcons}ic_favorite_tab_selected.svg";
  static const icFavoriteFill = "${basePathIcons}ic_favorite_fill.svg";
  static const icCategory = "${basePathIcons}ic_category.svg";
  static const icCategoryFill = "${basePathIcons}ic_category_fill.svg";
  static const icCategoryTabSelected =
      "${basePathIcons}ic_category_tab_selected.svg";
  static const icStatus = "${basePathIcons}ic_status.svg";
  static const icStatusTabSelected =
      "${basePathIcons}ic_status_tab_selected.svg";

  static const icOption = "${basePathIcons}icOption.svg";
  static const icFilter = "${basePathIcons}icFilter.svg";
  static const icFilterTwo = "${basePathIcons}icFilterTwo.svg";
  static const icFavoriteStar = "${basePathIcons}icFavoriteStar.svg";
  static const icEmptyData = "${basePathIcons}icEmptyData.svg";
  static const icBack = "${basePathIcons}icBack.svg";
  static const icSearch = "${basePathIcons}icSearch.svg";
  static const icCoinLogo = "${basePathIcons}icCoinLogo.svg";

  static const icTether = "${basePathIcons}icTether.svg";
  static const icTotalHoldings = "${basePathIcons}icTotalHoldings.svg";
  static const icCryptoFill = "${basePathIcons}icCryptoFill.svg";
  static const icCross = "${basePathIcons}icCross.svg";
  static const icCopy = "${basePathIcons}icCopy.svg";
  static const icCelebrate = "${basePathIcons}icCelebrate.svg";

  static const icEditRoundBg = "${basePathIcons}icEditRoundBg.png";
}

class FromKey {
  static const up = "up";
  static const down = "down";
  static const buy = "buy";
  static const sell = "sell";
  static const all = "all";
  static const buySell = "buy_sell";
  static const trade = "trade";
  static const dashboard = "dashboard";
}

class HistoryType {
  static const deposit = "deposit";
  static const withdraw = "withdraw";
  static const swap = "swap";
  static const buyOrder = "buy_order";
  static const sellOrder = "sell_order";
  static const transaction = "transaction";
  static const fiatDeposit = "fiat_deposit";
  static const fiatWithdrawal = "fiat_withdrawal";
}

class PreferenceKey {
  static const isDark = 'is_dark';
  static const languageKey = "language_key";
  static const isOnBoardingDone = 'is_on_boarding_done';
  static const isLoggedIn = "is_logged_in";
  static const accessToken = "access_token";
  static const accessType = "access_type";
  static const userObject = "user_object";
  static const settingsObject = "settings_object";
}

class DefaultValue {
  static const int kPasswordLength = 6;
  static const int codeLength = 6;
  static const String currency = "USD";
  static const String currencySymbol = "\$";
  static const String crispKey = "encrypt";

  static const int listLimitLarge = 20;
  static const int listLimitMedium = 10;
  static const int listLimitShort = 5;
  static const String country = "Bangladesh";
  static const String randomImage =
      "https://media.istockphoto.com/photos/high-angle-view-of-a-lake-and-forest-picture-id1337232523"; //"https://picsum.photos/200";
  static const String longString =
      "Expandable widgets are often used within a scroll view. "
      "When the user expands a widget, be it an ExpandablePanel or an Expandable with a custom control,"
      " they expect the expanded widget to fit within the viewable area (if possible). "
      "For example, if you show a list of articles with a summary of each article, "
      "and the user expands an article to read it, they expect the expanded article to "
      "occupy as much screen space as possible. The Expandable package contains a widget to "
      "help implement this behavior, ScrollOnExpand. Here's how to use it.";
  static const accessToken =
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiZDg5YmIwNmQ5YTgyNTYxYzgzZTJmMmYwZDNiOTIxMDZkYjE5YTYzNmIyYjU3N2I4NThkOTEyNzVmZGNiMzU3OGM1YWRhZjY2ZTM2YzY5YjYiLCJpYXQiOjE2NjQ0NDY2NTYuNjU2NjM3LCJuYmYiOjE2NjQ0NDY2NTYuNjU2NjQzLCJleHAiOjE2OTU5ODI2NTYuNjUxNjY5LCJzdWIiOiIyIiwic2NvcGVzIjpbXX0.PV-Mw0RDSfT0OWojilB-MFxxJIoh-b2iE0WYnW4zSNOMf0FP-1yUg4d1xERjeuzgirN3LWLBX_M8re3MBzfcR-rTIr-cRcDH2i_u4HF77YECVsFIqiUGkfUaaSf2SQa24Ha3SioG8OIYM25_WmXNsXKyrIMp7Vi0Qq_BjsQJyOkOFhqH-XEumORw73akGCkmrWA0WcL-om5xpj0GiafZs5qz19bNKzxzuF7q3Lguyo8df0PMpA_AhNmP4M7GpHT_gitlvINPRAHtD6p7WuHJ9w221EHOy1J97yVCgQy-7ymDZ6mZBAyDxRavP1j5H40GuS6ZtgUxbd-rF1t_VY96zxA4lS4uvEWjRzcBMu8TF2lspjb9WwYfUJHhew-mrq3Gy7wgfUkd-nItG2aOpeu6P8kJKcwGuoLN9wkZ_q7zsnphU8vHt5jH2IBCI_XpayG1CpRjhl10w4A2jip9evXlY1gPGOkCyCseunQpLcaq6wxltSqL6x4ZIxnWROIlNSJSiroco3SqeRDVNOHtC3B_vXW9TmE2lcceCO_Wv5VTNcgQxjKxLPyv-Szrc_FNLFm3OtseHR72qKv2qIOFdg_qZh3yZgCawRDQAYp0xo42c9FWAb_JU6lADew1QwPjpWi-OoI8qDSf4r3p0Jrdj4g8Lf-lAPXegi8MsQg5zNAzG0U";
}

const String google_api_key = "AIzaSyD8Sprfl49cbi9sRl1_zr6kAmjq1WStlxU";

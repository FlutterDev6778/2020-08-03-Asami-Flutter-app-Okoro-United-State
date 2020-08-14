import 'dart:async';

import 'package:flutter/material.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:keicy_progress_dialog/keicy_progress_dialog.dart';
import 'package:keicy_raised_button/keicy_raised_button.dart';
import 'package:keicy_text_form_field/keicy_text_form_field.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:keicy_network_image/keicy_network_image.dart';

import 'index.dart';
import 'package:asami_app/Pages/App/index.dart';
import 'package:asami_backend/Models/index.dart';

class TermsPage extends StatefulWidget {
  @override
  _TermsPageState createState() => _TermsPageState();
}

class _TermsPageState extends State<TermsPage> with TickerProviderStateMixin {
  TermsPageStyles _termsPageStyles;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _termsPageStyles = TermsPageMobileStyles(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TermsPageProvider()),
      ],
      child: Builder(builder: (context) {
        return _containerMain(context);
      }),
    );
  }

  Widget _containerMain(BuildContext context) {
    String terms = "Terms & Conditions";
    terms +=
        "\nBy downloading or using the app, these terms will automatically apply to you – you should make sure therefore that you read them carefully before using the app. You’re not allowed to copy, or modify the app, any part of the app, or our trademarks in any way. You’re not allowed to attempt to extract the source code of the app, and you also shouldn’t try to translate the app into other languages, or make derivative versions. The app itself, and all the trade marks, copyright, database rights and other intellectual property rights related to it, still belong to ASAMI, LLC.";
    terms += "\n";
    terms += "\n";
    terms +=
        "ASAMI, LLC is committed to ensuring that the app is as useful and efficient as possible. For that reason, we reserve the right to make changes to the app or to charge for its services, at any time and for any reason. We will never charge you for the app or its services without making it very clear to you exactly what you’re paying for.";
    terms += "\n";
    terms += "\n";
    terms +=
        "The Asami app stores and processes personal data that you have provided to us, in order to provide our Service. It’s your responsibility to keep your phone and access to the app secure. We therefore recommend that you do not jailbreak or root your phone, which is the process of removing software restrictions and limitations imposed by the official operating system of your device. It could make your phone vulnerable to malware/viruses/malicious programs, compromise your phone’s security features and it could mean that the Asami app won’t work properly or at all.";
    terms += "\n";
    terms += "\n";
    terms += "The app does use third party services that declare their own Terms and Conditions.";
    terms += "\n";
    terms += "\n";
    terms += "Link to Terms and Conditions of third party service providers used by the app";
    terms += "\n";
    terms += "\n";
    terms += "Google Play Services";
    terms += "\n";
    terms += "Google Play Services";
    terms += "\n";
    terms += "Google Analytics for Firebase";
    terms += "\n";
    terms += "Firebase Crashlytics";
    terms += "\n";
    terms +=
        "You should be aware that there are certain things that ASAMI, LLC will not take responsibility for. Certain functions of the app will require the app to have an active internet connection. The connection can be Wi-Fi, or provided by your mobile network provider, but ASAMI, LLC cannot take responsibility for the app not working at full functionality if you don’t have access to Wi-Fi, and you don’t have any of your data allowance left.";
    terms += "\n";
    terms += "\n";
    terms +=
        "If you’re using the app outside of an area with Wi-Fi, you should remember that your terms of the agreement with your mobile network provider will still apply. As a result, you may be charged by your mobile provider for the cost of data for the duration of the connection while accessing the app, or other third party charges. In using the app, you’re accepting responsibility for any such charges, including roaming data charges if you use the app outside of your home territory (i.e. region or country) without turning off data roaming. If you are not the bill payer for the device on which you’re using the app, please be aware that we assume that you have received permission from the bill payer for using the app.";
    terms += "\n";
    terms += "\n";
    terms +=
        "Along the same lines, ASAMI, LLC cannot always take responsibility for the way you use the app i.e. You need to make sure that your device stays charged – if it runs out of battery and you can’t turn it on to avail the Service, ASAMI, LLC cannot accept responsibility.";
    terms += "\n";
    terms += "\n";
    terms +=
        "With respect to ASAMI, LLC’s responsibility for your use of the app, when you’re using the app, it’s important to bear in mind that although we endeavour to ensure that it is updated and correct at all times, we do rely on third parties to provide information to us so that we can make it available to you. ASAMI, LLC accepts no liability for any loss, direct or indirect, you experience as a result of relying wholly on this functionality of the app.";
    terms += "\n";
    terms += "\n";
    terms +=
        "At some point, we may wish to update the app. The app is currently available on Android & iOS – the requirements for both systems(and for any additional systems we decide to extend the availability of the app to) may change, and you’ll need to download the updates if you want to keep using the app. ASAMI, LLC does not promise that it will always update the app so that it is relevant to you and/or works with the Android & iOS version that you have installed on your device. However, you promise to always accept updates to the application when offered to you, We may also wish to stop providing the app, and may terminate use of it at any time without giving notice of termination to you. Unless we tell you otherwise, upon any termination, (a) the rights and licenses granted to you in these terms will end; (b) you must stop using the app, and (if needed) delete it from your device.";
    terms += "\n";
    terms += "\n";
    terms += "Changes to This Terms and Conditions";
    terms += "\n";
    terms += "\n";
    terms +=
        "We may update our Terms and Conditions from time to time. Thus, you are advised to review this page periodically for any changes. We will notify you of any changes by posting the new Terms and Conditions on this page.";
    terms += "\n";
    terms += "\n";
    terms += "These terms and conditions are effective as of 2020-08-09";
    terms += "\n";
    terms += "\n";
    terms += "Contact Us";
    terms += "\n";
    terms += "\n";
    terms += "If you have any questions or suggestions about our Terms and Conditions, do not hesitate to contact us at info@asamiteashop.com.";
    terms += "\n";
    terms += "\n";
    terms += "This Terms and Conditions page was generated by App Privacy Policy Generator";

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(_termsPageStyles.deviceWidth, _termsPageStyles.asamiAppbarHeight),
        child: Container(
          padding: EdgeInsets.all(_termsPageStyles.asamiAppbarBottomPadding),
          alignment: Alignment.bottomCenter,
          color: AppColors.appbarColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  size: _termsPageStyles.appbarIconSize,
                  color: Colors.white,
                ),
              ),
              Text(
                TermsPageString.appbarTitle,
                style: TextStyle(
                  fontSize: _termsPageStyles.appbarTitleFontSize,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  size: _termsPageStyles.appbarIconSize,
                  color: AppColors.appbarColor,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: _termsPageStyles.deviceWidth,
          padding: EdgeInsets.symmetric(
            horizontal: _termsPageStyles.primaryHorizontalPadding,
            vertical: _termsPageStyles.primaryVerticalPadding,
          ),
          decoration: BoxDecoration(color: Colors.white),
          child: Text(terms, style: TextStyle(fontSize: _termsPageStyles.textFontSize)),
        ),
      ),
    );
  }
}

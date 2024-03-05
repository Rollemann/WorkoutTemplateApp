import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:workouttemplateapp/screens/settings_widgets/settings_caption_widget.dart';

class DonationWidget extends StatelessWidget {
  const DonationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SettingsCaptionWidget(
            title: AppLocalizations.of(context)!.settingTitleDonation,
            explanation:
                Text(AppLocalizations.of(context)!.settingExplanationDonation),
          ),
        ),
        TextButton.icon(
          onPressed: _launchURL,
          icon: const Icon(Icons.favorite),
          label: Text(AppLocalizations.of(context)!.donate),
        )
      ],
    );
  }

  Future<void> _launchURL() async {
    final Uri url = Uri.parse('https://www.buymeacoffee.com/suslikrolf');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}

import 'package:url_launcher/url_launcher.dart';
final Uri _url = Uri.parse('https://www.facebook.com/groups/SyrianCommunityGroup');
Future<void> _launchUrl() async {
  if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
  }
}

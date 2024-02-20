 class language  {
  final String name;
  final String flag;
  final String languageCode;
  language (this.name, this.languageCode, this.flag);

  static List<language> languageList() {
    return <language> [
      language("English", "en", "🇬🇧"),
      language("Arabic", "ar", "🇸🇦")
    ];
  }

 }
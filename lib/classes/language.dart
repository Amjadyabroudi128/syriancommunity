 class language  {
  final String name;
  final String languageCode;
  language (this.name, this.languageCode);

  static List<language> languageList() {
    return <language> [
      language("English", "en"),
      language("Arabic", "العربية"),
    ];
  }

 }
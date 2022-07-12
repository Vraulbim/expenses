class ThemeHelper {
  bool darkMode = false;
  static ThemeHelper instance = ThemeHelper();

  static updateTheme() {
    instance.darkMode = !instance.darkMode;
  }
}
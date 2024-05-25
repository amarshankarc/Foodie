abstract class AssetHelper {
  static String svgIcon(String svg) {
    return 'asset/svg/$svg';
  }static String pngIcon(String svg) {
    return 'asset/png/$svg';
  }

//--------------------------[icon]------------------------
  static get firebase => svgIcon('Firebase_icon.svg');

  static get google => svgIcon('Google__G__logo.svg');

  static get defaultDP => pngIcon('user-profile-icon.png');
}

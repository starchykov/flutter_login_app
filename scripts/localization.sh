# By default, Flutter only provides US English localizations.
# To add support for other languages, an application must specify additional MaterialApp (or CupertinoApp) properties,
# and include a package called flutter_localizations. As of January 2023, this package supports 79 languages.

# Add a new yaml file to the root directory of the Flutter project called l10n.yaml with the following content:
echo "arb-dir: lib/l10n" > ../l10n.yaml
echo "template-arb-file: app_en.arb" >> ../l10n.yaml
echo "output-localization-file: app_localizations.dart" >> ../l10n.yaml

cd ./../ || exit

# To use flutter_localizations, add the package as a dependency to your pubspec.yaml file, as well as the intl package:
flutter pub add flutter_localizations --sdk=flutter
flutter pub add intl:any

# Now, run flutter gen-l10n so that codegen takes place.
# You should see generated files in ${FLUTTER_PROJECT}/.dart_tool/flutter_gen/gen_l10n.
flutter gen-l10n

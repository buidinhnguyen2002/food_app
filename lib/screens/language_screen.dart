import 'package:final_project/providers/auth.dart';
import 'package:final_project/utils/functions.dart';
import 'package:final_project/widgets/bottom_widget.dart';
import 'package:final_project/widgets/common_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});
  static const routeName = "/language-screen";

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  int _selectedLanguage = 1;
  @override
  void initState() {
    super.initState();
    _selectedLanguage =
        Provider.of<Auth>(context, listen: false).selectedLanguage;
  }

  void changeLanguage(int i) {
    setState(() {
      _selectedLanguage = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);
    final languages = auth.languages;
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          AppLocalizations.of(context)!.label_language,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        final language = languages[index];
                        return Container(
                          padding: const EdgeInsets.all(15),
                          margin: const EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(0),
                            leading: Icon(Icons.language),
                            title: Text(language.name),
                            trailing: Radio(
                              value: language.value,
                              groupValue: _selectedLanguage,
                              onChanged: (value) => changeLanguage(value!),
                              fillColor:
                                  MaterialStateProperty.resolveWith<Color?>(
                                (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.selected)) {
                                    return Theme.of(context)
                                        .colorScheme
                                        .primary;
                                  }
                                  return Theme.of(context).colorScheme.primary;
                                },
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: languages.length,
                    ),
                  ),
                ],
              ),
            ),
          ),
          BottomWidget(
            child: CommonButton(
                title: AppLocalizations.of(context)!.button_apply,
                onPress: () {
                  auth.selectedLanguage = _selectedLanguage;
                  showNotification(context, AppLocalizations.of(context)!.label_Change_languages);
                  Future.delayed(
                    const Duration(seconds: 1, milliseconds: 50),
                    () => Navigator.pop(context),
                  );
                }),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'phone_input_screen.dart';

final languageProvider = StateProvider<String>((ref) => 'English');

class LanguageSelectionScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedLanguage = ref.watch(languageProvider);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 80),
            Image.asset(
              'asset/image/gallery.png',
              width: 42,
              height: 42,
              color: Color.fromRGBO(0, 0, 0, 1),
            ),
            const SizedBox(height: 42),
            const Text(
              "Please select your Language",
              style: TextStyle(
                color: Color.fromRGBO(0, 0, 0, 1),
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 11),
            const Text(
              "You can change the language \n at any time.",
              style: TextStyle(
                fontSize: 13,
                color: Color.fromRGBO(106, 108, 123, 1),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.only(left: 72, right: 72),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: selectedLanguage,
                  underline: SizedBox(),
                  items: <String>['English', 'Hindi', 'Spanish']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    ref.read(languageProvider.notifier).state = newValue!;
                  },
                ),
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: EdgeInsets.only(left: 72, right: 72),
              child: SizedBox(
                height: 48,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(46, 59, 98, 1),
                    padding: EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PhoneInputScreen()),
                    );
                  },
                  child: const Text(
                    "NEXT",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(),
            Container(
              height: 118,
              width: 400,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("asset/image/wave.png"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

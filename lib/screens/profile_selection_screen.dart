import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final profileSelectionProvider = StateProvider<String?>((ref) => null);

class ProfileSelectionScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedProfile = ref.watch(profileSelectionProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
          const  Text(
              "Please select your profile",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ProfileOption(
              imagePath: 'asset/image/shipper.png',
              title: "Shipper",
              description: "Lorem ipsum dolor sit amet, consectetur adipiscing",
              isSelected: selectedProfile == "Shipper",
              onTap: () {
                ref.read(profileSelectionProvider.notifier).state = "Shipper";
              },
            ),
           const SizedBox(height: 20),
            ProfileOption(
              imagePath: 'asset/image/transport.png',
              title: "Transporter",
              description: "Lorem ipsum dolor sit amet, consectetur adipiscing",
              isSelected: selectedProfile == "Transporter",
              onTap: () {
                ref.read(profileSelectionProvider.notifier).state =
                    "Transporter";
              },
            ),
          const  SizedBox(
              height: 24,
            ),
            SizedBox(
              height: 56,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:const Color.fromRGBO(46, 59, 98, 1),
                  padding:const EdgeInsets.symmetric(vertical: 14),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                onPressed: selectedProfile != null
                    ? () {
                        // Uncomment and replace with actual navigation once SuccessScreen is available
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => SuccessScreen()),
                        // );
                      }
                    : null,
                child: const Text(
                  "CONTINUE",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileOption extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  final bool isSelected;
  final VoidCallback onTap;

  const ProfileOption({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.description,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.withOpacity(0.1) : Colors.transparent,
          border: Border.all(
              color: isSelected
                  ? Color.fromRGBO(46, 59, 98, 1)
                  : Color.fromRGBO(46, 59, 98, 1)),
          borderRadius: BorderRadius.circular(8),
        ),
        padding:const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        child: Row(
          children: [
            Radio(
              value: true,
              groupValue: isSelected,
              onChanged: (_) => onTap(),
            ),
          const  SizedBox(width: 10),
            Image.asset(
              imagePath,
              width: 35,
              height: 20,
              fit: BoxFit.cover,
            ),
           const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Color.fromRGBO(47, 48, 55, 1),
                      fontSize: 21,
                    ),
                  ),
                const  SizedBox(height: 5),
                  Text(
                    description,
                    style:const TextStyle(
                        fontSize: 12, color: Color.fromRGBO(106, 108, 123, 1)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

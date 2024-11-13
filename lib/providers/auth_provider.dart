import 'package:flutter_riverpod/flutter_riverpod.dart';

final phoneNumberProvider = StateProvider<String>((ref) => '');
final verificationIdProvider = StateProvider<String?>((ref) => null);

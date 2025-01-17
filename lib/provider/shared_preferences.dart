import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'shared_preferences.g.dart';

@riverpod
Future<SharedPreferences> sharedPreferences(SharedPreferencesRef ref) async =>
    await SharedPreferences.getInstance();

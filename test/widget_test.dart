import 'package:flutter_test/flutter_test.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mse_dashboard/main.dart';

void main() {
  testWidgets('Dashboard login page sanity test', (WidgetTester tester) async {
    // Initialize GetStorage for test
    await GetStorage.init();

    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that we are on the login screen
    expect(find.text('Welcome Back!'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
  });
}

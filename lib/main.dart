import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:device_preview/device_preview.dart';
import 'models/transaction_model.dart';
import 'models/income_model.dart';
import 'models/category_summary.dart';
import 'view_models/transaction_provider.dart';
import 'views/home_view.dart';
import 'views/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TransactionModelAdapter());
  Hive.registerAdapter(IncomeModelAdapter());
  Hive.registerAdapter(CategorySummaryAdapter());

  final transactionProvider = TransactionProvider();
  await transactionProvider.init();

  runApp(
    DevicePreview(
      enabled: !bool.fromEnvironment('dart.vm.product'),
      builder: (context) => MyApp(transactionProvider: transactionProvider),
    ),
  );
}

class MyApp extends StatelessWidget {
  final TransactionProvider transactionProvider;

  const MyApp({super.key, required this.transactionProvider});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider.value(value: transactionProvider)],
      child: DevicePreview.appBuilder(
        context,
        MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Expense Tracker',
          theme: ThemeData(
            useMaterial3: true,
            scaffoldBackgroundColor: Colors.grey[50],
          ),
          home: const SplashScreen(),
          routes: {'/home': (context) => const HomeView()},
        ),
      ),
    );
  }
}

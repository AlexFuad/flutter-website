import 'package:flutter/material.dart';
import 'utils/app_theme.dart';
import 'pages/home_page.dart';
import 'pages/about_page.dart';
import 'pages/products_services_page.dart';
import 'pages/news_blogs_page.dart';
import 'pages/contact_page.dart';
import 'admin/pages/admin_login_page.dart';
import 'admin/pages/admin_dashboard_page.dart';

void main() {
  runApp(const CanielApp());
}

class CanielApp extends StatelessWidget {
  const CanielApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Caniel - Innovative Digital Solutions',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/about': (context) => const AboutPage(),
        '/products': (context) => const ProductsServicesPage(),
        '/news': (context) => const NewsBlogsPage(),
        '/contact': (context) => const ContactPage(),
        '/admin/login': (context) => const AdminLoginPage(),
        '/admin/dashboard': (context) => const AdminDashboardPage(),
      },
    );
  }
}

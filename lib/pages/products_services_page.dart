import 'package:flutter/material.dart';
import '../utils/app_theme.dart';
import '../widgets/responsive_navbar.dart';
import '../widgets/footer.dart';

class ProductsServicesPage extends StatefulWidget {
  const ProductsServicesPage({super.key});

  @override
  State<ProductsServicesPage> createState() => _ProductsServicesPageState();
}

class _ProductsServicesPageState extends State<ProductsServicesPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  int _selectedCategory = 0;

  void _navigateToPage(BuildContext context, int index) {
    final routes = [
      '/',
      '/about',
      '/products',
      '/news',
      '/contact',
      '/admin/login',
    ];
    if (index >= 0 && index < routes.length) {
      Navigator.pushNamed(context, routes[index]);
    }
  }

  final List<String> _categories = [
    'All',
    'Web Development',
    'Mobile Apps',
    'Cloud Solutions',
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Scaffold(
      appBar: ResponsiveNavbar(
        selectedIndex: 2,
        onMenuItemSelected: (index) => _navigateToPage(context, index),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeroSection(isMobile),
            _buildCategoryFilter(isMobile),
            _buildProductsGrid(isMobile),
            _buildPricingSection(isMobile),
            _buildCTASection(isMobile),
            const Footer(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection(bool isMobile) {
    return Container(
      height: isMobile ? 350 : 450,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.primaryColor.withOpacity(0.9),
            AppTheme.secondaryColor.withOpacity(0.8),
          ],
        ),
      ),
      child: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Products & Services',
                  style: TextStyle(
                    fontSize: isMobile ? 36 : 52,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 15),
                Text(
                  'Comprehensive Solutions for Your Digital Needs',
                  style: TextStyle(
                    fontSize: isMobile ? 18 : 22,
                    color: Colors.white.withOpacity(0.9),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryFilter(bool isMobile) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 60,
        vertical: 40,
      ),
      child: Wrap(
        spacing: 15,
        runSpacing: 15,
        alignment: WrapAlignment.center,
        children: List.generate(
          _categories.length,
          (index) => ElevatedButton(
            onPressed: () {
              setState(() {
                _selectedCategory = index;
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: _selectedCategory == index
                  ? AppTheme.primaryColor
                  : Colors.white,
              foregroundColor: _selectedCategory == index
                  ? Colors.white
                  : AppTheme.primaryColor,
              elevation: _selectedCategory == index ? 2 : 0,
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
                side: BorderSide(
                  color: _selectedCategory == index
                      ? AppTheme.primaryColor
                      : Colors.grey.shade300,
                ),
              ),
            ),
            child: Text(
              _categories[index],
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductsGrid(bool isMobile) {
    final products = [
      {
        'icon': Icons.web,
        'title': 'E-Commerce Platform',
        'description':
            'Complete online store solution with payment integration',
        'category': 1,
      },
      {
        'icon': Icons.phone_android,
        'title': 'Mobile Banking App',
        'description': 'Secure and intuitive mobile banking experience',
        'category': 2,
      },
      {
        'icon': Icons.cloud,
        'title': 'Cloud Migration',
        'description': 'Seamless transition to cloud infrastructure',
        'category': 3,
      },
      {
        'icon': Icons.analytics,
        'title': 'Analytics Dashboard',
        'description': 'Real-time data visualization and reporting',
        'category': 1,
      },
      {
        'icon': Icons.shopping_cart,
        'title': 'Inventory Management',
        'description': 'Streamline your inventory tracking and management',
        'category': 2,
      },
      {
        'icon': Icons.security,
        'title': 'Cybersecurity Suite',
        'description': 'Comprehensive security solutions for enterprises',
        'category': 3,
      },
    ];

    final filteredProducts = _selectedCategory == 0
        ? products
        : products.where((p) => p['category'] == _selectedCategory).toList();

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 60,
        vertical: 40,
      ),
      child: Column(
        children: [
          Wrap(
            spacing: 30,
            runSpacing: 30,
            alignment: WrapAlignment.center,
            children: filteredProducts.map((product) {
              return _buildProductCard(
                product['icon'] as IconData,
                product['title'] as String,
                product['description'] as String,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(IconData icon, String title, String description) {
    return Container(
      width: 320,
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 3,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppTheme.primaryColor, AppTheme.secondaryColor],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 30, color: Colors.white),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppTheme.textColor,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: const TextStyle(fontSize: 14, color: AppTheme.textLight),
          ),
          const SizedBox(height: 20),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              foregroundColor: AppTheme.primaryColor,
            ),
            child: const Text(
              'Learn More →',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPricingSection(bool isMobile) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 60,
        vertical: 60,
      ),
      color: AppTheme.lightColor,
      child: Column(
        children: [
          Text(
            'Flexible Pricing Plans',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 50),
          Wrap(
            spacing: 30,
            runSpacing: 30,
            alignment: WrapAlignment.center,
            children: [
              _buildPricingCard(
                'Starter',
                '\$499',
                'Perfect for small projects',
              ),
              _buildPricingCard(
                'Professional',
                '\$999',
                'Ideal for growing businesses',
                isPopular: true,
              ),
              _buildPricingCard(
                'Enterprise',
                'Custom',
                'For large-scale operations',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPricingCard(
    String name,
    String price,
    String description, {
    bool isPopular = false,
  }) {
    return Container(
      width: 280,
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: isPopular ? AppTheme.primaryColor : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: isPopular
                ? AppTheme.primaryColor.withOpacity(0.3)
                : Colors.grey.withOpacity(0.1),
            spreadRadius: isPopular ? 5 : 3,
            blurRadius: isPopular ? 15 : 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          if (isPopular)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Text(
                'Most Popular',
                style: TextStyle(
                  color: AppTheme.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          const SizedBox(height: 15),
          Text(
            name,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: isPopular ? Colors.white : AppTheme.textColor,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            price,
            style: TextStyle(
              fontSize: 42,
              fontWeight: FontWeight.bold,
              color: isPopular ? Colors.white : AppTheme.primaryColor,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: TextStyle(
              fontSize: 14,
              color: isPopular
                  ? Colors.white.withOpacity(0.9)
                  : AppTheme.textLight,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 25),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: isPopular ? Colors.white : AppTheme.primaryColor,
              foregroundColor: isPopular ? AppTheme.primaryColor : Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            child: const Text(
              'Get Started',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCTASection(bool isMobile) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 60,
        vertical: 60,
      ),
      child: Column(
        children: [
          Text(
            'Need a Custom Solution?',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 20),
          Text(
            'We can tailor our services to meet your specific requirements',
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text(
              'Request a Quote',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

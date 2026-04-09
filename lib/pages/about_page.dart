import 'package:flutter/material.dart';
import '../utils/app_theme.dart';
import '../widgets/responsive_navbar.dart';
import '../widgets/footer.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

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
        selectedIndex: 1,
        onMenuItemSelected: (index) => _navigateToPage(context, index),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeroSection(isMobile),
            _buildStorySection(isMobile),
            _buildTeamSection(isMobile),
            _buildValuesSection(isMobile),
            _buildStatsSection(isMobile),
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
                  'About Caniel',
                  style: TextStyle(
                    fontSize: isMobile ? 36 : 52,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 15),
                Text(
                  'Driving Innovation Since 2020',
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

  Widget _buildStorySection(bool isMobile) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 60,
        vertical: 60,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: isMobile
                ? [_buildStoryContent()]
                : [
                    Expanded(child: _buildStoryContent()),
                    const SizedBox(width: 50),
                    Expanded(
                      child: Container(
                        height: 350,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              AppTheme.primaryColor,
                              AppTheme.secondaryColor,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Icon(
                          Icons.business_center,
                          size: 100,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
          ),
        ],
      ),
    );
  }

  Widget _buildStoryContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Our Story', style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 20),
        Text(
          'Founded in 2020, Caniel has been at the forefront of digital innovation, '
          'helping businesses transform and thrive in the modern digital landscape.',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 20),
        Text(
          'Our mission is to deliver cutting-edge technology solutions that empower '
          'organizations to achieve their goals. We believe in the power of innovation, '
          'collaboration, and excellence to create lasting impact.',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 20),
        Text(
          'With a team of passionate professionals, we\'ve helped hundreds of clients '
          'across various industries navigate their digital transformation journey.',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }

  Widget _buildTeamSection(bool isMobile) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 60,
        vertical: 60,
      ),
      child: Column(
        children: [
          Text(
            'Meet Our Team',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 15),
          Text(
            'Talented individuals driving innovation',
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 50),
          Wrap(
            spacing: 30,
            runSpacing: 30,
            alignment: WrapAlignment.center,
            children: [
              _buildTeamMember('CEO & Founder', 'John Doe'),
              _buildTeamMember('CTO', 'Jane Smith'),
              _buildTeamMember('Lead Developer', 'Mike Johnson'),
              _buildTeamMember('Design Director', 'Sarah Williams'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTeamMember(String role, String name) {
    return Container(
      width: 200,
      padding: const EdgeInsets.all(25),
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
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.person,
              size: 60,
              color: AppTheme.primaryColor,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            name,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            role,
            style: TextStyle(fontSize: 14, color: AppTheme.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildValuesSection(bool isMobile) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 60,
        vertical: 60,
      ),
      color: AppTheme.darkCard,
      child: Column(
        children: [
          Text('Our Values', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 50),
          Wrap(
            spacing: 30,
            runSpacing: 30,
            alignment: WrapAlignment.center,
            children: [
              _buildValueCard('Innovation', 'Constantly pushing boundaries'),
              _buildValueCard('Excellence', 'Delivering top-quality solutions'),
              _buildValueCard(
                'Integrity',
                'Building trust through transparency',
              ),
              _buildValueCard('Collaboration', 'Working together for success'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildValueCard(String title, String description) {
    return Container(
      width: 250,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Icon(Icons.star, size: 40, color: AppTheme.primaryColor),
          const SizedBox(height: 15),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: TextStyle(fontSize: 14, color: AppTheme.textSecondary),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection(bool isMobile) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 60,
        vertical: 60,
      ),
      child: Column(
        children: [
          Text('Our Impact', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 50),
          Wrap(
            spacing: 50,
            runSpacing: 30,
            alignment: WrapAlignment.center,
            children: [
              _buildStatItem('200+', 'Projects Completed'),
              _buildStatItem('150+', 'Happy Clients'),
              _buildStatItem('50+', 'Team Members'),
              _buildStatItem('6+', 'Years Experience'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String number, String label) {
    return Column(
      children: [
        Text(
          number,
          style: const TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.bold,
            color: AppTheme.primaryColor,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          label,
          style: TextStyle(fontSize: 16, color: AppTheme.textSecondary),
        ),
      ],
    );
  }
}

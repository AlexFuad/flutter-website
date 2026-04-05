import 'package:flutter/material.dart';
import '../utils/app_theme.dart';
import '../widgets/responsive_navbar.dart';
import '../widgets/footer.dart';

class NewsBlogsPage extends StatefulWidget {
  const NewsBlogsPage({super.key});

  @override
  State<NewsBlogsPage> createState() => _NewsBlogsPageState();
}

class _NewsBlogsPageState extends State<NewsBlogsPage>
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
    'Company News',
    'Technology',
    'Industry Insights',
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
        selectedIndex: 3,
        onMenuItemSelected: (index) => _navigateToPage(context, index),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeroSection(isMobile),
            _buildCategoryFilter(isMobile),
            _buildFeaturedArticle(isMobile),
            _buildArticlesGrid(isMobile),
            _buildNewsletterSection(isMobile),
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
                  'News & Blogs',
                  style: TextStyle(
                    fontSize: isMobile ? 36 : 52,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 15),
                Text(
                  'Stay Updated with the Latest in Technology',
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

  Widget _buildFeaturedArticle(bool isMobile) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 60,
        vertical: 30,
      ),
      child: Container(
        padding: const EdgeInsets.all(40),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppTheme.primaryColor, AppTheme.secondaryColor],
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'FEATURED',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'The Future of AI in Business: Transforming Industries in 2026',
              style: TextStyle(
                fontSize: isMobile ? 24 : 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              'Discover how artificial intelligence is revolutionizing business operations, '
              'from automation to predictive analytics, and what it means for your organization.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white.withOpacity(0.9),
                height: 1.6,
              ),
            ),
            const SizedBox(height: 25),
            Row(
              children: [
                const CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, color: AppTheme.primaryColor),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'John Doe',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'March 28, 2026 • 5 min read',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildArticlesGrid(bool isMobile) {
    final articles = [
      {
        'category': 'Company News',
        'categoryIndex': 1,
        'title': 'Caniel Expands Operations to Southeast Asia',
        'excerpt':
            'We\'re excited to announce our new regional headquarters in Singapore.',
        'author': 'Jane Smith',
        'date': 'March 25, 2026',
        'readTime': '3 min read',
      },
      {
        'category': 'Technology',
        'categoryIndex': 2,
        'title': 'Flutter 4.0: What\'s New and Exciting',
        'excerpt':
            'Explore the latest features that make Flutter the top choice for cross-platform development.',
        'author': 'Mike Johnson',
        'date': 'March 22, 2026',
        'readTime': '7 min read',
      },
      {
        'category': 'Industry Insights',
        'categoryIndex': 3,
        'title': 'Cloud Computing Trends to Watch in 2026',
        'excerpt':
            'Stay ahead of the curve with these emerging cloud technologies.',
        'author': 'Sarah Williams',
        'date': 'March 18, 2026',
        'readTime': '6 min read',
      },
      {
        'category': 'Technology',
        'categoryIndex': 2,
        'title': 'Building Scalable Microservices with Docker',
        'excerpt': 'A comprehensive guide to containerizing your applications.',
        'author': 'Alex Chen',
        'date': 'March 15, 2026',
        'readTime': '8 min read',
      },
      {
        'category': 'Company News',
        'categoryIndex': 1,
        'title': 'Caniel Wins Innovation Award 2026',
        'excerpt':
            'Recognized for excellence in digital transformation solutions.',
        'author': 'Emily Davis',
        'date': 'March 10, 2026',
        'readTime': '4 min read',
      },
      {
        'category': 'Industry Insights',
        'categoryIndex': 3,
        'title': 'Cybersecurity Best Practices for Modern Enterprises',
        'excerpt':
            'Protect your business with these essential security strategies.',
        'author': 'David Lee',
        'date': 'March 5, 2026',
        'readTime': '9 min read',
      },
    ];

    final filteredArticles = _selectedCategory == 0
        ? articles
        : articles
              .where((a) => a['categoryIndex'] == _selectedCategory)
              .toList();

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
            children: filteredArticles.map((article) {
              return _buildArticleCard(
                article['category'] as String,
                article['title'] as String,
                article['excerpt'] as String,
                article['author'] as String,
                article['date'] as String,
                article['readTime'] as String,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildArticleCard(
    String category,
    String title,
    String excerpt,
    String author,
    String date,
    String readTime,
  ) {
    return Container(
      width: 350,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              category,
              style: const TextStyle(
                color: AppTheme.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(height: 15),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.textColor,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            excerpt,
            style: const TextStyle(fontSize: 14, color: AppTheme.textLight),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const CircleAvatar(
                radius: 15,
                backgroundColor: AppTheme.lightColor,
                child: Icon(
                  Icons.person,
                  size: 18,
                  color: AppTheme.primaryColor,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      author,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: AppTheme.textColor,
                      ),
                    ),
                    Text(
                      '$date • $readTime',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppTheme.textLight,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNewsletterSection(bool isMobile) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 60,
        vertical: 60,
      ),
      color: AppTheme.lightColor,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
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
                Icon(Icons.mail, size: 60, color: AppTheme.primaryColor),
                const SizedBox(height: 20),
                Text(
                  'Subscribe to Our Newsletter',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 10),
                Text(
                  'Get the latest updates delivered straight to your inbox',
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: isMobile ? 250 : 300,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Enter your email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 15,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: const Text(
                        'Subscribe',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

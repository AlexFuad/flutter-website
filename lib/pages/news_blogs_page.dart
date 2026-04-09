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
  final String _searchTerm = '';

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

  final List<CategoryItem> _categories = [
    CategoryItem(id: 'all', name: 'Semua Artikel', icon: Icons.all_inclusive),
    CategoryItem(
      id: 'web-development',
      name: 'Web Development',
      icon: Icons.code,
    ),
    CategoryItem(
      id: 'digital-marketing',
      name: 'Digital Marketing',
      icon: Icons.trending_up,
    ),
    CategoryItem(id: 'business', name: 'Business Tips', icon: Icons.people),
    CategoryItem(id: 'technology', name: 'Technology', icon: Icons.settings),
    CategoryItem(id: 'tips', name: 'Tips & Tricks', icon: Icons.lightbulb),
  ];

  final List<ArticleItem> _articles = [
    ArticleItem(
      id: '1',
      title: '10 Tren Web Development Terbaru di 2026',
      excerpt:
          'Pelajari tren terbaru dalam web development yang akan mendominasi industri teknologi di tahun 2026.',
      category: 'web-development',
      author: 'Daniel RN',
      date: '2026-01-15',
      readTime: '8 menit',
      featured: true,
    ),
    ArticleItem(
      id: '2',
      title: 'Strategi Digital Marketing untuk UMKM',
      excerpt:
          'Panduan lengkap strategi digital marketing yang efektif dan terjangkau untuk usaha mikro, kecil, dan menengah.',
      category: 'digital-marketing',
      author: 'Alex Fuad',
      date: '2026-01-12',
      readTime: '6 menit',
      featured: true,
    ),
    ArticleItem(
      id: '3',
      title: 'Cara Memilih Technology Stack yang Tepat',
      excerpt:
          'Tips memilih kombinasi teknologi yang tepat untuk proyek web development Anda berdasarkan kebutuhan bisnis.',
      category: 'technology',
      author: 'Eca Tatianna',
      date: '2026-01-10',
      readTime: '10 menit',
      featured: false,
    ),
    ArticleItem(
      id: '4',
      title: 'Optimasi SEO untuk Website Bisnis',
      excerpt:
          'Teknik-teknik SEO terbaru yang dapat meningkatkan ranking website bisnis Anda di mesin pencari Google.',
      category: 'digital-marketing',
      author: 'Aprilianti P',
      date: '2026-01-08',
      readTime: '7 menit',
      featured: false,
    ),
    ArticleItem(
      id: '5',
      title: 'Transformasi Digital untuk Perusahaan Tradisional',
      excerpt:
          'Langkah-langkah praktis untuk memulai transformasi digital di perusahaan tradisional.',
      category: 'business',
      author: 'Alex Fuad',
      date: '2026-01-05',
      readTime: '12 menit',
      featured: false,
    ),
    ArticleItem(
      id: '6',
      title: 'Flutter 4.0: What\'s New and Exciting',
      excerpt:
          'Explore the latest features that make Flutter the top choice for cross-platform development.',
      category: 'web-development',
      author: 'Mike Johnson',
      date: '2026-01-03',
      readTime: '7 min read',
      featured: false,
    ),
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
      body: Container(
        decoration: BoxDecoration(gradient: AppTheme.heroGradient),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeroSection(isMobile),
              _buildCategoryFilter(isMobile),
              if (_selectedCategory == 0) _buildFeaturedArticles(isMobile),
              _buildArticlesList(isMobile),
              _buildNewsletterSection(isMobile),
              const Footer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeroSection(bool isMobile) {
    return Container(
      height: isMobile ? 350 : 450,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ShaderMask(
                shaderCallback: (bounds) =>
                    AppTheme.primaryGradient.createShader(bounds),
                child: Text(
                  'Blog & Insights',
                  style: TextStyle(
                    fontSize: isMobile ? 36 : 56,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                'Wawasan terbaru dari Caniel Agency untuk pertumbuhan bisnis digital Anda.',
                style: TextStyle(
                  fontSize: isMobile ? 18 : 22,
                  color: AppTheme.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
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
        spacing: 12,
        runSpacing: 12,
        alignment: WrapAlignment.center,
        children: List.generate(_categories.length, (index) {
          final isSelected = _selectedCategory == index;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedCategory = index;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                gradient: isSelected ? AppTheme.buttonGradient : null,
                color: isSelected ? null : Colors.transparent,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: isSelected ? Colors.transparent : AppTheme.darkBorder,
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _categories[index].icon,
                    size: 16,
                    color: isSelected ? Colors.white : AppTheme.primaryColor,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _categories[index].name,
                    style: TextStyle(
                      color: isSelected ? Colors.white : AppTheme.primaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildFeaturedArticles(bool isMobile) {
    final featuredArticles = _articles.where((a) => a.featured).toList();

    if (featuredArticles.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 60,
        vertical: 30,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShaderMask(
            shaderCallback: (bounds) =>
                AppTheme.primaryGradient.createShader(bounds),
            child: Text(
              'Artikel Unggulan',
              style: TextStyle(
                fontSize: isMobile ? 28 : 36,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Artikel pilihan yang paling banyak dibaca dan memberikan value terbaik.',
            style: TextStyle(fontSize: 16, color: AppTheme.textSecondary),
          ),
          const SizedBox(height: 30),
          if (isMobile)
            Column(
              children: featuredArticles
                  .map(
                    (article) => Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: _buildFeaturedArticleCard(article, isMobile),
                    ),
                  )
                  .toList(),
            )
          else
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: featuredArticles
                  .map(
                    (article) => Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: _buildFeaturedArticleCard(article, isMobile),
                      ),
                    ),
                  )
                  .toList(),
            ),
        ],
      ),
    );
  }

  Widget _buildFeaturedArticleCard(ArticleItem article, bool isMobile) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.darkCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.darkBorder, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              image: const DecorationImage(
                image: NetworkImage(
                  'https://images.unsplash.com/photo-1595872018818-97555653a011',
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Unggulan',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.person, size: 14, color: AppTheme.textSecondary),
                    const SizedBox(width: 5),
                    Text(
                      article.author,
                      style: TextStyle(
                        fontSize: 13,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Icon(
                      Icons.calendar_today,
                      size: 14,
                      color: AppTheme.textSecondary,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      article.date,
                      style: TextStyle(
                        fontSize: 13,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Icon(
                      Icons.schedule,
                      size: 14,
                      color: AppTheme.textSecondary,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      article.readTime,
                      style: TextStyle(
                        fontSize: 13,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  article.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  article.excerpt,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppTheme.textSecondary,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 15),
                GestureDetector(
                  onTap: () {
                    // Navigate to article detail
                  },
                  child: Row(
                    children: [
                      Text(
                        'Baca Selengkapnya',
                        style: TextStyle(
                          color: AppTheme.primaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Icon(
                        Icons.arrow_forward,
                        size: 16,
                        color: AppTheme.primaryColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildArticlesList(bool isMobile) {
    List<ArticleItem> filteredArticles;

    if (_selectedCategory == 0) {
      filteredArticles = _articles.where((a) => !a.featured).toList();
    } else {
      final categoryId = _categories[_selectedCategory].id;
      filteredArticles = _articles
          .where((a) => a.category == categoryId)
          .toList();
    }

    if (filteredArticles.isEmpty) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 60),
        child: Center(
          child: Column(
            children: [
              Icon(Icons.article_outlined, size: 80, color: AppTheme.textMuted),
              const SizedBox(height: 20),
              Text(
                'Tidak ada artikel ditemukan',
                style: TextStyle(fontSize: 18, color: AppTheme.textSecondary),
              ),
            ],
          ),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 60,
        vertical: 40,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_selectedCategory != 0)
            ShaderMask(
              shaderCallback: (bounds) =>
                  AppTheme.primaryGradient.createShader(bounds),
              child: Text(
                _categories[_selectedCategory].name,
                style: TextStyle(
                  fontSize: isMobile ? 28 : 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          if (_selectedCategory != 0) const SizedBox(height: 10),
          if (_selectedCategory != 0)
            Text(
              'Menampilkan ${filteredArticles.length} artikel',
              style: TextStyle(fontSize: 16, color: AppTheme.textSecondary),
            ),
          if (_selectedCategory != 0) const SizedBox(height: 30),
          ...filteredArticles
              .map(
                (article) => Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: _buildArticleListItem(article, isMobile),
                ),
              )
              .toList(),
        ],
      ),
    );
  }

  Widget _buildArticleListItem(ArticleItem article, bool isMobile) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.darkCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.darkBorder, width: 1),
      ),
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 180,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    image: const DecorationImage(
                      image: NetworkImage(
                        'https://images.unsplash.com/photo-1595872018818-97555653a011',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: _buildArticleCardContent(article),
                ),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 300,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                    ),
                    image: const DecorationImage(
                      image: NetworkImage(
                        'https://images.unsplash.com/photo-1595872018818-97555653a011',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: _buildArticleCardContent(article),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildArticleCardContent(ArticleItem article) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                _categories
                    .firstWhere(
                      (c) => c.id == article.category,
                      orElse: () => _categories[0],
                    )
                    .name,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.primaryColor,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Icon(Icons.calendar_today, size: 13, color: AppTheme.textSecondary),
            const SizedBox(width: 5),
            Text(
              article.date,
              style: TextStyle(fontSize: 12, color: AppTheme.textSecondary),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          article.title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimary,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          article.excerpt,
          style: TextStyle(
            fontSize: 14,
            color: AppTheme.textSecondary,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 15,
                  backgroundColor: AppTheme.darkBorder,
                  child: Icon(
                    Icons.person,
                    size: 16,
                    color: AppTheme.primaryColor,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  article.author,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: AppTheme.textPrimary,
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                // Navigate to detail
              },
              child: Row(
                children: [
                  Text(
                    'Baca',
                    style: TextStyle(
                      color: AppTheme.primaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Icon(
                    Icons.arrow_forward,
                    size: 16,
                    color: AppTheme.primaryColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildNewsletterSection(bool isMobile) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 60,
        vertical: 60,
      ),
      child: Container(
        padding: const EdgeInsets.all(40),
        decoration: AppTheme.glassEffect,
        child: Column(
          children: [
            Icon(Icons.mail, size: 60, color: AppTheme.primaryColor),
            const SizedBox(height: 20),
            ShaderMask(
              shaderCallback: (bounds) =>
                  AppTheme.primaryGradient.createShader(bounds),
              child: Text(
                'Subscribe to Our Newsletter',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Dapatkan artikel terbaru langsung di email Anda',
              style: TextStyle(fontSize: 16, color: AppTheme.textSecondary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            if (isMobile)
              Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Email Anda',
                      filled: true,
                      fillColor: AppTheme.darkCard,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: AppTheme.darkBorder),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: AppTheme.darkBorder),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: AppTheme.primaryColor,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: AppTheme.buttonGradient,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: const Center(
                      child: Text(
                        'Berlangganan',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            else
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 300,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Email Anda',
                        filled: true,
                        fillColor: AppTheme.darkCard,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: AppTheme.darkBorder),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: AppTheme.darkBorder),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: AppTheme.primaryColor,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Container(
                    decoration: BoxDecoration(
                      gradient: AppTheme.buttonGradient,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                    child: const Text(
                      'Berlangganan',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class CategoryItem {
  final String id;
  final String name;
  final IconData icon;

  const CategoryItem({
    required this.id,
    required this.name,
    required this.icon,
  });
}

class ArticleItem {
  final String id;
  final String title;
  final String excerpt;
  final String category;
  final String author;
  final String date;
  final String readTime;
  final bool featured;

  const ArticleItem({
    required this.id,
    required this.title,
    required this.excerpt,
    required this.category,
    required this.author,
    required this.date,
    required this.readTime,
    this.featured = false,
  });
}

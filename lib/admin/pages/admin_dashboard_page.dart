import 'package:flutter/material.dart';
import '../../utils/app_theme.dart';
import '../widgets/admin_sidebar.dart';
import 'news_management_page.dart';

class AdminDashboardPage extends StatefulWidget {
  const AdminDashboardPage({super.key});

  @override
  State<AdminDashboardPage> createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage> {
  int _selectedMenuIndex = 0;
  bool _isSidebarExpanded = true;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      body: Row(
        children: [
          if (!isMobile)
            AdminSidebar(
              selectedIndex: _selectedMenuIndex,
              onMenuItemSelected: (index) {
                setState(() {
                  _selectedMenuIndex = index;
                });
              },
              isExpanded: _isSidebarExpanded,
              onToggle: () {
                setState(() {
                  _isSidebarExpanded = !_isSidebarExpanded;
                });
              },
            ),
          Expanded(child: _buildMainContent(isMobile)),
        ],
      ),
    );
  }

  Widget _buildMainContent(bool isMobile) {
    switch (_selectedMenuIndex) {
      case 0:
        return _buildDashboardContent(isMobile);
      case 1:
        return const NewsManagementPage();
      case 2:
        return _buildPlaceholder('Products Management', Icons.shopping_bag);
      case 3:
        return _buildPlaceholder('Settings', Icons.settings);
      default:
        return _buildDashboardContent(isMobile);
    }
  }

  Widget _buildDashboardContent(bool isMobile) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(isMobile ? 20 : 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Dashboard',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Selamat datang di panel Admin CMS',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppTheme.primaryColor.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.calendar_today,
                      size: 16,
                      color: AppTheme.primaryColor,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'April 5, 2026',
                      style: const TextStyle(
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),

          // Stats cards
          if (!isMobile)
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    'Total Artikel',
                    '24',
                    Icons.article,
                    const Color(0xFF3B82F6),
                    '+12% from last month',
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: _buildStatCard(
                    'Published',
                    '18',
                    Icons.check_circle,
                    const Color(0xFF10B981),
                    '75% of total',
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: _buildStatCard(
                    'Drafts',
                    '6',
                    Icons.drafts,
                    const Color(0xFFF59E0B),
                    'Pending review',
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: _buildStatCard(
                    'Total Views',
                    '12.5K',
                    Icons.visibility,
                    const Color(0xFF8B5CF6),
                    '+23% this week',
                  ),
                ),
              ],
            ),
          if (isMobile)
            Column(
              children: [
                _buildStatCard(
                  'Total Artikel',
                  '24',
                  Icons.article,
                  const Color(0xFF3B82F6),
                  '+12% from last month',
                ),
                const SizedBox(height: 15),
                _buildStatCard(
                  'Published',
                  '18',
                  Icons.check_circle,
                  const Color(0xFF10B981),
                  '75% of total',
                ),
                const SizedBox(height: 15),
                _buildStatCard(
                  'Drafts',
                  '6',
                  Icons.drafts,
                  const Color(0xFFF59E0B),
                  'Pending review',
                ),
                const SizedBox(height: 15),
                _buildStatCard(
                  'Total Views',
                  '12.5K',
                  Icons.visibility,
                  const Color(0xFF8B5CF6),
                  '+23% this week',
                ),
              ],
            ),
          const SizedBox(height: 30),

          // Recent activity and quick actions
          if (!isMobile)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 2, child: _buildRecentActivity()),
                const SizedBox(width: 20),
                Expanded(child: _buildQuickActions()),
              ],
            ),
          if (isMobile) ...[
            _buildRecentActivity(),
            const SizedBox(height: 20),
            _buildQuickActions(),
          ],
        ],
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
    String trend,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [color.withOpacity(0.2), color.withOpacity(0.1)],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              Row(
                children: [
                  const Icon(
                    Icons.trending_up,
                    size: 16,
                    color: Color(0xFF10B981),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    trend,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF10B981),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 15),
          Text(
            value,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            title,
            style: TextStyle(fontSize: 13, color: AppTheme.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivity() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF141414),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.darkBorder.withOpacity(0.5),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.access_time,
                    color: Color(0xFF3B82F6),
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Aktivitas Terbaru',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _selectedMenuIndex = 1;
                  });
                },
                child: const Text(
                  'Lihat Semua',
                  style: TextStyle(color: Color(0xFF3B82F6)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildActivityItem(
            'Artikel baru dipublish',
            'Flutter 4.0: What\'s New',
            '2 jam yang lalu',
            Icons.check_circle,
            const Color(0xFF10B981),
          ),
          _buildActivityItem(
            'Draft disimpan',
            'Cloud Computing Trends 2026',
            '5 jam yang lalu',
            Icons.save,
            const Color(0xFF3B82F6),
          ),
          _buildActivityItem(
            'Artikel diperbarui',
            'AI in Business Transformation',
            '1 hari yang lalu',
            Icons.edit,
            const Color(0xFFF59E0B),
          ),
          _buildActivityItem(
            'Komentar disetujui',
            'On: Mobile App Development Guide',
            '2 hari yang lalu',
            Icons.comment,
            const Color(0xFF8B5CF6),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem(
    String action,
    String target,
    String time,
    IconData icon,
    Color color,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  action,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textPrimary,
                    fontSize: 14,
                  ),
                ),
                Text(
                  target,
                  style: TextStyle(fontSize: 12, color: AppTheme.textSecondary),
                ),
              ],
            ),
          ),
          Text(time, style: TextStyle(fontSize: 11, color: AppTheme.textMuted)),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF141414),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.darkBorder.withOpacity(0.5),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.settings, color: Color(0xFF8B5CF6), size: 20),
              const SizedBox(width: 8),
              const Text(
                'Aksi Cepat',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildQuickActionItem('Artikel Baru', Icons.add_circle_outline, () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NewsManagementPage(),
              ),
            );
          }),
          _buildQuickActionItem('Kelola Semua Artikel', Icons.list_alt, () {
            setState(() {
              _selectedMenuIndex = 1;
            });
          }),
          _buildQuickActionItem(
            'Manage Products',
            Icons.shopping_bag_outlined,
            () {},
          ),
          _buildQuickActionItem('Settings', Icons.settings_outlined, () {}),
        ],
      ),
    );
  }

  Widget _buildQuickActionItem(
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    gradient: AppTheme.buttonGradient,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: Colors.white, size: 18),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppTheme.textPrimary,
                      fontSize: 14,
                    ),
                  ),
                ),
                const Icon(
                  Icons.chevron_right,
                  color: AppTheme.textSecondary,
                  size: 18,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholder(String title, IconData icon) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 80, color: AppTheme.textMuted.withOpacity(0.3)),
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Coming Soon',
            style: TextStyle(fontSize: 16, color: AppTheme.textSecondary),
          ),
        ],
      ),
    );
  }
}

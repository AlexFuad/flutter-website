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
          Expanded(
            child: _buildMainContent(isMobile),
          ),
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
      padding: const EdgeInsets.all(30),
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
                  Text(
                    'Dashboard',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Welcome back, Admin!',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today,
                        size: 16, color: AppTheme.primaryColor),
                    const SizedBox(width: 8),
                    Text(
                      'April 5, 2026',
                      style: const TextStyle(
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),

          // Stats cards
          Wrap(
            spacing: 20,
            runSpacing: 20,
            children: [
              _buildStatCard(
                'Total Articles',
                '24',
                Icons.article,
                AppTheme.primaryColor,
                '+12% from last month',
              ),
              _buildStatCard(
                'Published',
                '18',
                Icons.check_circle,
                Colors.green,
                '75% of total',
              ),
              _buildStatCard(
                'Drafts',
                '6',
                Icons.drafts,
                Colors.orange,
                'Pending review',
              ),
              _buildStatCard(
                'Total Views',
                '12.5K',
                Icons.visibility,
                Colors.purple,
                '+23% this week',
              ),
            ],
          ),
          const SizedBox(height: 40),

          // Recent activity and quick actions
          if (!isMobile)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: _buildRecentActivity(),
                ),
                const SizedBox(width: 30),
                Expanded(
                  child: _buildQuickActions(),
                ),
              ],
            ),
          if (isMobile) ...[
            _buildRecentActivity(),
            const SizedBox(height: 30),
            _buildQuickActions(),
          ],
        ],
      ),
    );
  }

  Widget _buildStatCard(
      String title, String value, IconData icon, Color color, String trend) {
    return Container(
      width: 250,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              Text(
                trend,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.green,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Text(
            value,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              color: AppTheme.textLight,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivity() {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Recent Activity',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.textColor,
            ),
          ),
          const SizedBox(height: 20),
          _buildActivityItem(
            'New article published',
            'Flutter 4.0: What\'s New',
            '2 hours ago',
            Icons.check_circle,
            Colors.green,
          ),
          _buildActivityItem(
            'Draft saved',
            'Cloud Computing Trends 2026',
            '5 hours ago',
            Icons.save,
            Colors.blue,
          ),
          _buildActivityItem(
            'Article updated',
            'AI in Business Transformation',
            '1 day ago',
            Icons.edit,
            Colors.orange,
          ),
          _buildActivityItem(
            'Comment approved',
            'On: Mobile App Development Guide',
            '2 days ago',
            Icons.comment,
            Colors.purple,
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem(
      String action, String target, String time, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  action,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textColor,
                  ),
                ),
                Text(
                  target,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppTheme.textLight,
                  ),
                ),
              ],
            ),
          ),
          Text(
            time,
            style: const TextStyle(
              fontSize: 12,
              color: AppTheme.textLight,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Quick Actions',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.textColor,
            ),
          ),
          const SizedBox(height: 20),
          _buildQuickActionItem(
            'Create New Article',
            Icons.add_circle_outline,
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NewsManagementPage(),
                ),
              );
            },
          ),
          _buildQuickActionItem(
            'View All News',
            Icons.list_alt,
            () {
              setState(() {
                // Navigate to news list
              });
            },
          ),
          _buildQuickActionItem(
            'Manage Products',
            Icons.shopping_bag_outlined,
            () {},
          ),
          _buildQuickActionItem(
            'Settings',
            Icons.settings_outlined,
            () {},
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionItem(
      String title, IconData icon, VoidCallback onTap) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: AppTheme.lightColor,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                Icon(icon, color: AppTheme.primaryColor, size: 20),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppTheme.textColor,
                  ),
                ),
                const Spacer(),
                const Icon(Icons.chevron_right, color: AppTheme.textLight),
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
          Icon(icon, size: 80, color: AppTheme.primaryColor.withOpacity(0.3)),
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppTheme.textColor,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Coming Soon',
            style: TextStyle(
              fontSize: 16,
              color: AppTheme.textLight,
            ),
          ),
        ],
      ),
    );
  }
}

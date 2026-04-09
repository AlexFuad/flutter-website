import 'package:flutter/material.dart';
import '../../utils/app_theme.dart';

class AdminSidebar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onMenuItemSelected;
  final bool isExpanded;
  final VoidCallback onToggle;

  const AdminSidebar({
    super.key,
    required this.selectedIndex,
    required this.onMenuItemSelected,
    required this.isExpanded,
    required this.onToggle,
  });

  final List<MenuItem> menuItems = const [
    MenuItem(icon: Icons.dashboard, label: 'Dashboard', index: 0),
    MenuItem(icon: Icons.article, label: 'News & Blogs', index: 1),
    MenuItem(icon: Icons.shopping_bag, label: 'Products', index: 2),
    MenuItem(icon: Icons.settings, label: 'Settings', index: 3),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isExpanded ? 256 : 72,
      decoration: BoxDecoration(
        color: const Color(0xFF141414),
        border: Border(
          right: BorderSide(
            color: AppTheme.darkBorder.withOpacity(0.5),
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          // Logo and toggle
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (isExpanded)
                  Expanded(
                    child: Row(
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            gradient: AppTheme.primaryGradient,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(
                            child: Text(
                              'C',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'CMS',
                          style: TextStyle(
                            color: AppTheme.textPrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      gradient: AppTheme.primaryGradient,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Text(
                        'C',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                IconButton(
                  icon: Icon(
                    isExpanded ? Icons.chevron_left : Icons.chevron_right,
                    color: AppTheme.textSecondary,
                    size: 20,
                  ),
                  onPressed: onToggle,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),

          const Divider(color: Color(0xFF2A2A2A), height: 1),

          // Menu items
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 12),
              children: List.generate(
                menuItems.length,
                (index) => _buildMenuItem(
                  context,
                  menuItems[index],
                  selectedIndex == menuItems[index].index,
                ),
              ),
            ),
          ),

          // Logout button
          const Divider(color: Color(0xFF2A2A2A), height: 1),
          _buildLogoutButton(context),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, MenuItem item, bool isSelected) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Material(
        color: isSelected
            ? AppTheme.primaryColor.withOpacity(0.2)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: () => onMenuItemSelected(item.index),
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                Icon(
                  item.icon,
                  color: isSelected
                      ? AppTheme.primaryColor
                      : AppTheme.textSecondary,
                  size: 18,
                ),
                if (isExpanded) const SizedBox(width: 12),
                if (isExpanded)
                  Expanded(
                    child: Text(
                      item.label,
                      style: TextStyle(
                        color: isSelected
                            ? AppTheme.primaryColor
                            : AppTheme.textSecondary,
                        fontSize: 14,
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.normal,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                backgroundColor: AppTheme.darkCard,
                title: const Text(
                  'Logout',
                  style: TextStyle(color: AppTheme.textPrimary),
                ),
                content: const Text(
                  'Are you sure you want to logout?',
                  style: TextStyle(color: AppTheme.textSecondary),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: AppTheme.textSecondary),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(context, '/admin/login');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: const Text('Logout'),
                  ),
                ],
              ),
            );
          },
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                const Icon(Icons.logout, color: Colors.red, size: 18),
                if (isExpanded) const SizedBox(width: 12),
                if (isExpanded)
                  const Expanded(
                    child: Text(
                      'Logout',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MenuItem {
  final IconData icon;
  final String label;
  final int index;

  const MenuItem({
    required this.icon,
    required this.label,
    required this.index,
  });
}

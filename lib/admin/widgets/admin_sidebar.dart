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
      width: isExpanded ? 250 : 70,
      decoration: BoxDecoration(
        color: AppTheme.darkColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(2, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          // Logo and toggle
          Container(
            height: 70,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => onMenuItemSelected(0),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [AppTheme.primaryColor, AppTheme.secondaryColor],
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        'C',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                if (isExpanded) const SizedBox(width: 12),
                if (isExpanded)
                  const Expanded(
                    child: Text(
                      'Caniel CMS',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                IconButton(
                  icon: Icon(
                    isExpanded ? Icons.chevron_left : Icons.chevron_right,
                    color: Colors.white70,
                    size: 20,
                  ),
                  onPressed: onToggle,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),

          const Divider(color: Colors.white24, height: 1),

          // Menu items
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 10),
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
          const Divider(color: Colors.white24, height: 1),
          _buildLogoutButton(context),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
      BuildContext context, MenuItem item, bool isSelected) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      child: Material(
        color: isSelected
            ? AppTheme.primaryColor.withOpacity(0.2)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: () => onMenuItemSelected(item.index),
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 15,
              vertical: isExpanded ? 12 : 14,
            ),
            child: Row(
              children: [
                Icon(
                  item.icon,
                  color: isSelected ? AppTheme.primaryColor : Colors.white70,
                  size: 22,
                ),
                if (isExpanded) const SizedBox(width: 12),
                if (isExpanded)
                  Expanded(
                    child: Text(
                      item.label,
                      style: TextStyle(
                        color: isSelected ? AppTheme.primaryColor : Colors.white70,
                        fontSize: 14,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
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
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Logout'),
                content: const Text('Are you sure you want to logout?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
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
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 15,
              vertical: isExpanded ? 12 : 14,
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.logout,
                  color: Colors.red,
                  size: 22,
                ),
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

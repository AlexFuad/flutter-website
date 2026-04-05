import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

class ResponsiveNavbar extends StatefulWidget implements PreferredSizeWidget {
  final int selectedIndex;
  final Function(int) onMenuItemSelected;

  const ResponsiveNavbar({
    super.key,
    required this.selectedIndex,
    required this.onMenuItemSelected,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<ResponsiveNavbar> createState() => _ResponsiveNavbarState();
}

class _ResponsiveNavbarState extends State<ResponsiveNavbar>
    with SingleTickerProviderStateMixin {
  final List<String> menuItems = [
    'Home',
    'About',
    'Products & Services',
    'News & Blogs',
    'Contact',
    'Login',
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 2,
      leading: isMobile
          ? PopupMenuButton<String>(
              icon: const Icon(Icons.menu, color: AppTheme.primaryColor),
              onSelected: (value) {
                if (value == 'Login') {
                  Navigator.pushNamed(context, '/admin/login');
                } else {
                  final index = menuItems.indexOf(value);
                  widget.onMenuItemSelected(index);
                }
              },
              itemBuilder: (context) => menuItems.map((item) {
                return PopupMenuItem<String>(value: item, child: Text(item));
              }).toList(),
            )
          : null,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => widget.onMenuItemSelected(0),
            child: Row(
              children: [
                Container(
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
                const SizedBox(width: 10),
                const Text(
                  'Caniel',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryColor,
                  ),
                ),
              ],
            ),
          ),
          if (!isMobile)
            Row(
              children: [
                ...List.generate(
                  menuItems.length - 1,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextButton(
                      onPressed: () => widget.onMenuItemSelected(index),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        foregroundColor: widget.selectedIndex == index
                            ? AppTheme.primaryColor
                            : AppTheme.textLight,
                      ),
                      child: Text(
                        menuItems[index],
                        style: TextStyle(
                          fontWeight: widget.selectedIndex == index
                              ? FontWeight.bold
                              : FontWeight.normal,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
                // Login button with special styling
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/admin/login');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.login, size: 16),
                        SizedBox(width: 6),
                        Text(
                          'Login',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

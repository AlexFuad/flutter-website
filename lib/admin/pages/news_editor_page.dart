import 'package:flutter/material.dart';
import '../../utils/app_theme.dart';
import '../models/news_model.dart';
import '../services/news_service.dart';

class NewsEditorPage extends StatefulWidget {
  final NewsModel? news;

  const NewsEditorPage({super.key, this.news});

  @override
  State<NewsEditorPage> createState() => _NewsEditorPageState();
}

class _NewsEditorPageState extends State<NewsEditorPage> {
  final _formKey = GlobalKey<FormState>();
  final NewsService _newsService = NewsService();

  late TextEditingController _titleController;
  late TextEditingController _excerptController;
  late TextEditingController _contentController;
  late TextEditingController _authorController;
  late TextEditingController _readTimeController;

  String _selectedCategory = 'Company News';
  bool _isPublished = true;
  bool _isLoading = false;

  final List<String> _categories = [
    'Company News',
    'Technology',
    'Industry Insights',
  ];

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.news?.title ?? '');
    _excerptController = TextEditingController(
      text: widget.news?.excerpt ?? '',
    );
    _contentController = TextEditingController(
      text: widget.news?.content ?? '',
    );
    _authorController = TextEditingController(text: widget.news?.author ?? '');
    _readTimeController = TextEditingController(
      text: widget.news?.readTime ?? '',
    );
    _selectedCategory = widget.news?.category ?? 'Company News';
    _isPublished = widget.news?.isPublished ?? true;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _excerptController.dispose();
    _contentController.dispose();
    _authorController.dispose();
    _readTimeController.dispose();
    super.dispose();
  }

  Future<void> _saveArticle() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      await Future.delayed(const Duration(milliseconds: 500));

      final now = DateTime.now();
      final formattedDate =
          '${_getMonthName(now.month)} ${now.day}, ${now.year}';

      if (widget.news == null) {
        // Create new article
        final newArticle = NewsModel(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          title: _titleController.text,
          excerpt: _excerptController.text,
          content: _contentController.text,
          category: _selectedCategory,
          author: _authorController.text,
          date: formattedDate,
          readTime: _readTimeController.text,
          isPublished: _isPublished,
        );
        _newsService.addNews(newArticle);
      } else {
        // Update existing article
        final updatedArticle = widget.news!.copyWith(
          title: _titleController.text,
          excerpt: _excerptController.text,
          content: _contentController.text,
          category: _selectedCategory,
          author: _authorController.text,
          readTime: _readTimeController.text,
          isPublished: _isPublished,
        );
        _newsService.updateNews(widget.news!.id!, updatedArticle);
      }

      setState(() {
        _isLoading = false;
      });

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              widget.news == null
                  ? 'Article created successfully'
                  : 'Article updated successfully',
            ),
            backgroundColor: Colors.green,
          ),
        );
      }
    }
  }

  String _getMonthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return months[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.news != null;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Scaffold(
      backgroundColor: AppTheme.lightColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.textColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          isEditing ? 'Edit Article' : 'Create New Article',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppTheme.textColor,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: ElevatedButton.icon(
              onPressed: _isLoading ? null : _saveArticle,
              icon: _isLoading
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : const Icon(Icons.save, size: 18),
              label: Text(_isLoading ? 'Saving...' : 'Save'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                foregroundColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(isMobile ? 20 : 30),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Main content area
              if (!isMobile)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 2, child: _buildMainForm()),
                    const SizedBox(width: 30),
                    Expanded(child: _buildSidebar()),
                  ],
                ),
              if (isMobile) ...[
                _buildMainForm(),
                const SizedBox(height: 30),
                _buildSidebar(),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMainForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        _buildFormField(
          controller: _titleController,
          label: 'Article Title',
          hint: 'Enter a compelling title',
          icon: Icons.title,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a title';
            }
            return null;
          },
        ),
        const SizedBox(height: 20),

        // Excerpt
        _buildFormField(
          controller: _excerptController,
          label: 'Excerpt / Summary',
          hint: 'Brief summary of the article (2-3 sentences)',
          icon: Icons.short_text,
          maxLines: 3,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter an excerpt';
            }
            return null;
          },
        ),
        const SizedBox(height: 20),

        // Content
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.lightColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(11),
                    topRight: Radius.circular(11),
                  ),
                ),
                child: Row(
                  children: [
                    _buildToolbarButton(Icons.format_bold, () {}),
                    _buildToolbarButton(Icons.format_italic, () {}),
                    _buildToolbarButton(Icons.format_list_bulleted, () {}),
                    _buildToolbarButton(Icons.format_list_numbered, () {}),
                    const SizedBox(width: 10),
                    _buildToolbarButton(Icons.link, () {}),
                    _buildToolbarButton(Icons.image, () {}),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Article Content',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textColor,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _contentController,
                      maxLines: 12,
                      decoration: InputDecoration(
                        hintText: 'Write your article content here...',
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.all(10),
                        filled: true,
                        fillColor: AppTheme.lightColor,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter content';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSidebar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Publishing settings
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Publishing',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textColor,
                ),
              ),
              const SizedBox(height: 20),

              // Category
              const Text(
                'Category',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textLight,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: AppTheme.lightColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedCategory,
                    isExpanded: true,
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: AppTheme.primaryColor,
                    ),
                    items: _categories.map((category) {
                      return DropdownMenuItem(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedCategory = value!;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Author
              _buildFormField(
                controller: _authorController,
                label: 'Author',
                hint: 'Author name',
                icon: Icons.person,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter author name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Read time
              _buildFormField(
                controller: _readTimeController,
                label: 'Read Time',
                hint: 'e.g., 5 min read',
                icon: Icons.schedule,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter read time';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Published status
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Publish Immediately',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textColor,
                    ),
                  ),
                  Switch(
                    value: _isPublished,
                    onChanged: (value) {
                      setState(() {
                        _isPublished = value;
                      });
                    },
                    activeColor: AppTheme.primaryColor,
                  ),
                ],
              ),
              Text(
                _isPublished
                    ? 'Article will be published immediately'
                    : 'Article will be saved as draft',
                style: const TextStyle(fontSize: 12, color: AppTheme.textLight),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFormField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppTheme.textColor,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon, color: AppTheme.primaryColor),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppTheme.primaryColor,
                width: 2,
              ),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
          validator: validator,
        ),
      ],
    );
  }

  Widget _buildToolbarButton(IconData icon, VoidCallback onPressed) {
    return Container(
      margin: const EdgeInsets.only(right: 5),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(6),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Icon(icon, size: 18, color: AppTheme.textLight),
          ),
        ),
      ),
    );
  }
}

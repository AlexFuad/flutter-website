import 'package:flutter/material.dart';
import '../models/news_model.dart';

class NewsService extends ChangeNotifier {
  final List<NewsModel> _newsList = [
    NewsModel(
      id: '1',
      title: 'Caniel Expands Operations to Southeast Asia',
      excerpt: 'We\'re excited to announce our new regional headquarters in Singapore.',
      content: 'Full article content here...',
      category: 'Company News',
      author: 'Jane Smith',
      date: 'March 25, 2026',
      readTime: '3 min read',
      isPublished: true,
    ),
    NewsModel(
      id: '2',
      title: 'Flutter 4.0: What\'s New and Exciting',
      excerpt: 'Explore the latest features that make Flutter the top choice for cross-platform development.',
      content: 'Full article content here...',
      category: 'Technology',
      author: 'Mike Johnson',
      date: 'March 22, 2026',
      readTime: '7 min read',
      isPublished: true,
    ),
    NewsModel(
      id: '3',
      title: 'Cloud Computing Trends to Watch in 2026',
      excerpt: 'Stay ahead of the curve with these emerging cloud technologies.',
      content: 'Full article content here...',
      category: 'Industry Insights',
      author: 'Sarah Williams',
      date: 'March 18, 2026',
      readTime: '6 min read',
      isPublished: false,
    ),
  ];

  List<NewsModel> get newsList => _newsList;

  List<NewsModel> getPublishedNews() {
    return _newsList.where((news) => news.isPublished).toList();
  }

  List<NewsModel> getDraftNews() {
    return _newsList.where((news) => !news.isPublished).toList();
  }

  void addNews(NewsModel news) {
    _newsList.add(news);
    notifyListeners();
  }

  void updateNews(String id, NewsModel updatedNews) {
    final index = _newsList.indexWhere((news) => news.id == id);
    if (index != -1) {
      _newsList[index] = updatedNews;
      notifyListeners();
    }
  }

  void deleteNews(String id) {
    _newsList.removeWhere((news) => news.id == id);
    notifyListeners();
  }

  void togglePublishStatus(String id) {
    final index = _newsList.indexWhere((news) => news.id == id);
    if (index != -1) {
      _newsList[index] = _newsList[index].copyWith(
        isPublished: !_newsList[index].isPublished,
      );
      notifyListeners();
    }
  }

  NewsModel? getNewsById(String id) {
    try {
      return _newsList.firstWhere((news) => news.id == id);
    } catch (e) {
      return null;
    }
  }

  Map<String, int> getNewsStats() {
    return {
      'total': _newsList.length,
      'published': getPublishedNews().length,
      'drafts': getDraftNews().length,
    };
  }
}

import 'package:flutter/widgets.dart';

mixin InfiniteScrollMixin<T extends StatefulWidget> on State<T> {
  late ScrollController _scrollController;
  final double _scrollThreashold = 200.0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - _scrollThreashold) {
      onLoadMore();
    }
  }

  void onLoadMore();

  ScrollController get scrollController => _scrollController;
}

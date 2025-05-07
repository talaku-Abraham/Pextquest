import 'package:flutter/widgets.dart';

class SearchFieldController extends ChangeNotifier {
  final TextEditingController _textEditingController = TextEditingController();

  TextEditingController get textEditingController => _textEditingController;

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
}

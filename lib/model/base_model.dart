import 'package:flutter/material.dart';
import 'package:woke_out/enum/app_state.dart';

class BaseModel extends ChangeNotifier {
  ViewState _viewState;

  ViewState get viewState => _viewState;

  setViewState(ViewState viewState) {
    _viewState = viewState;
    notifyListeners();
  }
}

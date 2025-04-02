import 'package:flutter_bloc/flutter_bloc.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingInitial());

  int _currentPageIndex = 0; // Track the current page index

  int get currentPageIndex => _currentPageIndex;

  void nextPage() {
    if (_currentPageIndex < 2) { // Assuming there are 3 pages (0, 1, 2)
      _currentPageIndex++;
      emit(OnboardingPageChanged(_currentPageIndex));
    }
  }

  void previousPage() {
    if (_currentPageIndex > 0) {
      _currentPageIndex--;
      emit(OnboardingPageChanged(_currentPageIndex));
    }
  }
}
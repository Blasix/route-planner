import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeState {
  const HomeState({
    required this.isTemplate,
    required this.isRecent,
  });

  final bool isTemplate, isRecent;

  HomeState copyWith({
    bool? isRecent,
    bool? isTemplate,
  }) {
    return HomeState(
      isRecent: isRecent ?? this.isRecent,
      isTemplate: isTemplate ?? this.isTemplate,
    );
  }
}

class HomeStateNotifier extends Notifier<HomeState> {
  HomeStateNotifier() : super();

  void setRecent(bool isRecent) {
    state = state.copyWith(isRecent: isRecent);
  }

  void setTemplate(bool isTemplate) {
    state = state.copyWith(isTemplate: isTemplate);
  }

  @override
  HomeState build() {
    return const HomeState(isRecent: true, isTemplate: true);
  }
}

final homeStateProvider =
    NotifierProvider<HomeStateNotifier, HomeState>(HomeStateNotifier.new);

// final homeStateProvider = NotifierProvider<TemplateNotifier, HomeState>(TemplateNotifier
//     );

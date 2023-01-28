import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeState {
  const HomeState({
    required this.isRecent,
  });

  final bool isRecent;

  HomeState copyWith({
    bool? isRecent,
  }) {
    return HomeState(
      isRecent: isRecent ?? this.isRecent,
    );
  }
}

class HomeStateNotifier extends Notifier<HomeState> {
  HomeStateNotifier() : super();

  void setRecent(bool isRecent) {
    state = state.copyWith(isRecent: isRecent);
  }

  @override
  HomeState build() {
    return const HomeState(isRecent: true);
  }
}

final homeStateProvider =
    NotifierProvider<HomeStateNotifier, HomeState>(HomeStateNotifier.new);

// final homeStateProvider = NotifierProvider<TemplateNotifier, HomeState>(TemplateNotifier
//     );

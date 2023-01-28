import 'package:hooks_riverpod/hooks_riverpod.dart';

class Template {
  const Template({
    required this.isWalking,
    required this.distance,
  });

  final bool isWalking;
  final int distance;

  Template copyWith({
    String? uuid,
    bool? isWalking,
    int? distance,
  }) {
    return Template(
        isWalking: isWalking ?? this.isWalking,
        distance: distance ?? this.distance);
  }
}

class TemplateNotifier extends Notifier<Template> {
  TemplateNotifier() : super();

  void setWalking(bool isWalking) {
    state = state.copyWith(isWalking: isWalking);
  }

  void setDistance(bool upOrDown) {
    if (state.distance == 0 && !upOrDown) {
      return;
    }
    state = state.copyWith(distance: state.distance + (upOrDown ? 1 : -1));
  }

  @override
  Template build() {
    return const Template(
      isWalking: true,
      distance: 10,
    );
  }
}

final templateNotifierProvider =
    NotifierProvider<TemplateNotifier, Template>(TemplateNotifier.new);

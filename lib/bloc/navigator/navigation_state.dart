part of 'navigation_bloc.dart';

class NavigationState extends Equatable{
  final List<PageConfiguration> pages;

  const NavigationState(this.pages);

  @override
  List<Object?> get props => [pages];
}

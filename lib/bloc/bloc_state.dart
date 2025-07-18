part of 'bloc_bloc.dart';

@immutable
sealed class BlocState {}

final class BlocInitial extends BlocState {}

final class BlocLoading extends BlocState {}

final class BlocSuccess extends BlocState {
  final List<Item> item;
  BlocSuccess(this.item);
}

final class BlocFailed extends BlocState {}

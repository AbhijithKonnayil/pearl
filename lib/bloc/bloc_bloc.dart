import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pearl/Item.dart';

part 'bloc_event.dart';
part 'bloc_state.dart';

class BlocBloc extends Bloc<BlocEvent, BlocState> {
  BlocBloc() : super(BlocInitial()) {
    on<LoadItems>((event, emit) async {
      emit(BlocLoading());
      List<Item> items = await apiCall();
      emit(BlocSuccess(items));
    });
  }

  apiCall() async {
    try {
      final response = await mockApi();
      List<Item> items = response
          .map<Item>((json) => Item.fromJson(json))
          .toList();
      return items;
    } catch (e) {
      print('Error fetching items: $e');
    }
  }

  mockApi() async {
    // Simulate an API call
    await Future.delayed(const Duration(seconds: 2));
    return [
      {
        'title': 'Item 1',
        'isFav': true,
        'timestamp': '2023-10-01T12:00:00Z',
        'tag': 'New',
      },
      {
        'title': 'Item 2',
        'isFav': false,
        'timestamp': '2023-10-02T12:00:00Z',
        'tag': 'Old',
      },
    ];
  }
}

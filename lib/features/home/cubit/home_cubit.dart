import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cantwait28/repositories/item_repository.dart';

import '../../../models/item_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._itemRepository) : super(const HomeState());

  final ItemRepository _itemRepository;

  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    _streamSubscription = _itemRepository.getItemsStream().listen(
      (items) {
        emit(HomeState(items: items));
      },
    )..onError(
        (error) {
          emit(const HomeState(loadingErrorOccured: true));
        },
      );
  }

  Future<void> remove({required String documentID}) async {
    try {
      await _itemRepository.delete(id: documentID);
    } catch (error) {
      emit(
        const HomeState(removingErrorOccured: true),
      );
      start();
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}

import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../../repositories/item_repository.dart';

part 'add_state.dart';

class AddCubit extends Cubit<AddState> {
  AddCubit(this._itemRepository) : super(const AddState());

  final ItemRepository _itemRepository;

  Future<void> add(
    String title,
    String imageURL,
    DateTime releaseDate,
  ) async {
    try {
      await _itemRepository.add(title, imageURL, releaseDate);
      emit(const AddState(saved: true));
    } catch (error) {
      emit(AddState(errorMessage: error.toString()));
    }
  }
}

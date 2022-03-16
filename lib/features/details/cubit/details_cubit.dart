import 'package:bloc/bloc.dart';
import 'package:cantwait28/models/item_model.dart';
import 'package:cantwait28/repositories/item_repository.dart';

part 'details_state.dart';

class DetailsCubit extends Cubit<DetailsState> {
  DetailsCubit(this._itemRepository) : super(DetailsState(itemModel: null));

  final ItemRepository _itemRepository;

  Future<void> getItemWithID(String id) async {
    final itemModel = await _itemRepository.get(id: id);
    emit(DetailsState(itemModel: itemModel));
  }
}

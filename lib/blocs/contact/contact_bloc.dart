
import 'package:e_book_admin/items/items.dart';
import 'package:e_book_admin/repository/repositories.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'contact_event.dart';
part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final ContactRepository _contactRepository;

  ContactBloc({required ContactRepository contactRepository})
      : _contactRepository = contactRepository,
        super(ContactLoading()){
    on<LoadContact>(_onLoadContact);
    on<UpdateContact>(_onUpdateContact);
  }
  void _onLoadContact(event, Emitter<ContactState> emit) async{
    List<ContactItem>? data = await _contactRepository.getAllContact();
    add(UpdateContact(data!));

  }
  void _onUpdateContact(event, Emitter<ContactState> emit) async{
    emit(ContactLoaded(contacts: event.contacts));
  }
}

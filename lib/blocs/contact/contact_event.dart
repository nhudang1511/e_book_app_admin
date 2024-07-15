part of 'contact_bloc.dart';
abstract class ContactEvent extends Equatable{
  const ContactEvent();
  @override
  List<Object?> get props => [];
}

class LoadContact extends ContactEvent{
  @override
  List<Object?> get props => [];
}

class UpdateContact extends ContactEvent{
  final List<ContactItem> contacts;

  const UpdateContact(this.contacts);
  @override
  List<Object?> get props => [];
}

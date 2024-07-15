part of 'contact_bloc.dart';

abstract class ContactState extends Equatable{

  const ContactState();
  @override
  List<Object?> get props => [];
}

class ContactLoading extends ContactState{
  @override
  List<Object?> get props => [];
}
class ContactLoaded extends ContactState{
  final List<ContactItem> contacts;

  const ContactLoaded({this.contacts = const <ContactItem>[]});
  @override
  List<Object?> get props => [contacts];
}
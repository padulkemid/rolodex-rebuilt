import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:rolodex/data/contact.dart';

typedef AlphabetizedContactMap = SplayTreeMap<String, List<Contact>>;

class ContactGroup {
  final int id;
  final String label;
  final String? title;
  final List<Contact> _contacts;
  final bool permanent;

  List<Contact> get contacts => _contacts;

  factory ContactGroup({
    required int id,
    required String label,
    String? title,
    List<Contact>? contacts,
    bool permanent = false,
  }) {
    final c = contacts ?? <Contact>[];

    _sortContacts(c);

    return ContactGroup._internal(
      id: id,
      label: label,
      title: title,
      contacts: c,
      permanent: permanent,
    );
  }

  ContactGroup._internal({
    required this.id,
    required this.label,
    String? title,
    List<Contact>? contacts,
    this.permanent = false,
  }) : title = title ?? label,
       _contacts = contacts ?? <Contact>[];

  AlphabetizedContactMap get alphabetizedContacts {
    final contactsMap = AlphabetizedContactMap();
    for (final contact in _contacts) {
      final lastInitial = contact.lastName[0].toUpperCase();
      if (contactsMap.containsKey(lastInitial)) {
        contactsMap[lastInitial]!.add(contact);
      } else {
        contactsMap[lastInitial] = [contact];
      }
    }
    return contactsMap;
  }
}

/// Sorts a list of [contacts] alphabetically by
/// last name, then first name, then middle name.
/// If names are identical, sorts by contact ID to ensure consistent ordering.
void _sortContacts(List<Contact> contacts) {
  contacts.sort((a, b) {
    final checkLastName = a.lastName.compareTo(b.lastName);
    if (checkLastName != 0) {
      return checkLastName;
    }
    final checkFirstName = a.firstName.compareTo(b.firstName);
    if (checkFirstName != 0) {
      return checkFirstName;
    }
    if (a.middleName != null && b.middleName != null) {
      final checkMiddleName = a.middleName!.compareTo(b.middleName!);
      if (checkMiddleName != 0) {
        return checkMiddleName;
      }
    } else if (a.middleName != null || b.middleName != null) {
      return a.middleName != null ? 1 : -1;
    }

    // If both contacts have the exact same name, order by first created.
    return a.id.compareTo(b.id);
  });
}

final allPhone = ContactGroup(
  id: 0,
  permanent: true,
  label: 'All iPhone',
  title: 'iPhone',
  contacts: allContacts.toList(),
);

final friends = ContactGroup(
  id: 1,
  label: 'Friends',
  contacts: [allContacts.elementAt(3)],
);

final work = ContactGroup(id: 2, label: 'Work');

List<ContactGroup> generateSeedData() {
  return [allPhone, friends, work];
}

class ContactGroupsModel {
  final ValueNotifier<List<ContactGroup>> _listsNotifier;

  ValueNotifier<List<ContactGroup>> get listsNotifier => _listsNotifier;
  List<ContactGroup> get lists => listsNotifier.value;

  ContactGroupsModel() : _listsNotifier = ValueNotifier(generateSeedData());

  ContactGroup findContactList(int id) => lists[id];

  void dispose() {
    _listsNotifier.dispose();
  }
}

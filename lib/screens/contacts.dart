import 'package:flutter/cupertino.dart';
import 'package:rolodex/data/contact.dart';
import 'package:rolodex/data/contact_group.dart';
import 'package:rolodex/main.dart';

class ContactListsPage extends StatelessWidget {
  const ContactListsPage({super.key, required this.listId});

  final int listId;

  @override
  Widget build(BuildContext context) {
    return _ContactListsView(
      listId: listId,
      automaticallyImplyLeading: true,
    );
  }
}

class _ContactListsView extends StatelessWidget {
  const _ContactListsView({
    required this.listId,
    this.automaticallyImplyLeading = true,
  });

  final int listId;
  final bool automaticallyImplyLeading;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: ValueListenableBuilder<List<ContactGroup>>(
        valueListenable: contactGroupsModel.listsNotifier,
        builder: (_, contactGroups, _) {
          final contactList = contactGroupsModel.findContactList(listId);
          final contacts = contactList.alphabetizedContacts;
          final initials = contacts.keys.toList();

          return CustomScrollView(
            slivers: [
              CupertinoSliverNavigationBar.search(
                largeTitle: Text(contactList.label),
                automaticallyImplyLeading: automaticallyImplyLeading,
                searchField: CupertinoSearchTextField(
                  suffixIcon: Icon(CupertinoIcons.mic_fill),
                  suffixMode: .always,
                ),
              ),
              SliverList.builder(
                itemCount: initials.length,
                itemBuilder: (_, index) => ContactListSection(
                  lastInitial: initials[index],
                  contacts: contacts[initials[index]]!,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class ContactListSection extends StatelessWidget {
  const ContactListSection({
    super.key,
    required this.lastInitial,
    required this.contacts,
  });

  final String lastInitial;
  final List<Contact> contacts;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: .fromSTEB(20, 0, 20, 0),
      child: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Align(
            alignment: .bottomStart,
            child: Text(
              lastInitial,
              style: CupertinoTheme.of(context).textTheme.textStyle,
            ),
          ),
          CupertinoListSection(
            backgroundColor: CupertinoColors.systemBackground,
            dividerMargin: 0,
            additionalDividerMargin: 0,
            topMargin: 4,
            children: [
              for (final contact in contacts)
                CupertinoListTile(
                  title: Text('${contact.firstName} ${contact.lastName}'),
                  padding: .all(0),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class ContactListDetail extends StatelessWidget {
  const ContactListDetail({super.key, required this.listId});

  final int listId;

  @override
  Widget build(BuildContext context) {
    return _ContactListsView(
      listId: listId,
      automaticallyImplyLeading: true,
    );
  }
}

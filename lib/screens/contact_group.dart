import 'package:flutter/cupertino.dart';
import 'package:rolodex/data/contact.dart';
import 'package:rolodex/data/contact_group.dart';
import 'package:rolodex/main.dart';

class ContactGroupsPage extends StatelessWidget {
  const ContactGroupsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _ContactGroupsView(
      selectedListId: 0,
      onListSelected: (list) {
        debugPrint(list.toString());
      },
    );
  }
}

class _ContactGroupsView extends StatelessWidget {
  const _ContactGroupsView({
    required this.onListSelected,
    this.selectedListId,
  });

  final int? selectedListId;
  final void Function(ContactGroup) onListSelected;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.extraLightBackgroundGray,
      child: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            largeTitle: Text('Lists'),
          ),
          SliverFillRemaining(
            child: ValueListenableBuilder<List<ContactGroup>>(
              valueListenable: contactGroupsModel.listsNotifier,
              builder: (_, List<ContactGroup> contactLists, _) =>
                  CupertinoListSection.insetGrouped(
                    header: Text('iPhone'),
                    children: [
                      for (final contactList in contactLists)
                        CupertinoListTile(
                          leading: contactList.id == 0
                              ? _LeadingIcon(CupertinoIcons.group)
                              : _LeadingIcon(CupertinoIcons.person_2),
                          title: Text(contactList.label),
                          onTap: () => onListSelected(contactList),
                          trailing: _TrailingIcon(
                            contacts: contactList.contacts,
                          ),
                        ),
                    ],
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TrailingIcon extends StatelessWidget {
  const _TrailingIcon({required this.contacts});

  final List<Contact> contacts;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: .min,
      children: [
        Text(
          contacts.length.toString(),
          style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
            color: CupertinoColors.systemGrey,
          ),
        ),
        Icon(
          CupertinoIcons.forward,
          color: CupertinoColors.systemGrey3,
          size: 18,
        ),
      ],
    );
  }
}

class _LeadingIcon extends StatelessWidget {
  const _LeadingIcon(this.icon);

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      weight: 900,
      size: 32,
    );
  }
}

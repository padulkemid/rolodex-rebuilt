import 'package:flutter/cupertino.dart';
import 'package:rolodex/screens/contact_group.dart';
import 'package:rolodex/screens/contacts.dart';

const largeScreenMinWidth = 600;

class AdaptiveLayout extends StatefulWidget {
  const AdaptiveLayout({super.key});

  @override
  State<AdaptiveLayout> createState() => _AdaptiveLayoutState();
}

class _AdaptiveLayoutState extends State<AdaptiveLayout> {
  int _selectedListId = 0;

  void _onContactListSelected(int listId) {
    setState(() {
      _selectedListId = listId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, BoxConstraints constraints) {
        final isLargeScreen = constraints.maxWidth > largeScreenMinWidth;

        if (isLargeScreen) {
          return _ContactGroupsLargeScreen(
            selectedListId: _selectedListId,
            onListSelected: _onContactListSelected,
          );
        }
        /* return ContactListsPage(
          listId: 0,
        ); */

        return ContactGroupsPage();
      },
    );
  }
}

class _ContactGroupsLargeScreen extends StatelessWidget {
  const _ContactGroupsLargeScreen({
    required this.selectedListId,
    required this.onListSelected,
  });

  final int selectedListId;
  final void Function(int) onListSelected;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.extraLightBackgroundGray,
      child: SafeArea(
        child: Row(
          children: [
            SizedBox(
              width: 320,
              child: ContactGroupsSidebar(
                selectedListId: selectedListId,
                onListSelected: onListSelected,
              ),
            ),
            Container(
              width: 1,
              color: CupertinoColors.separator,
            ),
            Expanded(
              child: ContactListDetail(listId: selectedListId),
            ),
          ],
        ),
      ),
    );
  }
}

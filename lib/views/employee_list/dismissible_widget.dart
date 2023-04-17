part of 'employee_list_view.dart';

class DismissibleWidget extends StatelessWidget {
  const DismissibleWidget(
      {super.key, required this.index, required this.onTap});

  final int index;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {}
      },
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.endToStart) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text(Constants.empDeleted),
              action: SnackBarAction(label: Constants.undo, onPressed: () {}),
            ),
          );
          return true;
        }
        return false;
      },
      direction: DismissDirection.endToStart,
      background: Container(
        color: Theme.of(context).colorScheme.error,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.delete_outline,
              color: Theme.of(context).colorScheme.onError,
            )
          ],
        ),
      ),
      child: InkWell(
        onTap: onTap,
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 0),
          elevation: 0,
          child: ListTile(
            title: Text(
              "Employee Number $index",
              maxLines: 1,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Text("Full-Stack Developer", maxLines: 1),
                SizedBox(
                  height: 4,
                ),
                Text("Date", maxLines: 1),
              ],
            ),
            isThreeLine: true,
          ),
        ),
      ),
    );
  }
}

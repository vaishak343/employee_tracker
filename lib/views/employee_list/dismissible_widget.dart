part of 'employee_list_view.dart';

class DismissibleWidget extends StatelessWidget {
  const DismissibleWidget({
    super.key,
    required this.model,
    required this.onTap,
    required this.onDelete,
    required this.undoDelete,
  });

  final EmployeeModel model;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final VoidCallback undoDelete;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          onDelete();
        }
      },
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.endToStart) {
          ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: const Text(Constants.empDeleted),
              action: SnackBarAction(
                label: Constants.undo,
                onPressed: undoDelete,
              ),
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
              model.empName,
              maxLines: 1,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(model.empRole, maxLines: 1),
                const SizedBox(
                  height: 4,
                ),
                if (model.toDate == null)
                  Text(
                    'From ${DateFormat('dd MMM yyyy').format(model.fromDate)}',
                    maxLines: 1,
                  )
                else
                  Text(
                    '${DateFormat('dd MMM yyyy').format(model.fromDate)} - ${DateFormat('dd MMM yyyy').format(model.toDate!)}',
                    maxLines: 1,
                  ),
              ],
            ),
            isThreeLine: true,
          ),
        ),
      ),
    );
  }
}

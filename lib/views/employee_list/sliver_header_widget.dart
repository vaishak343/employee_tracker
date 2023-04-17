part of 'employee_list_view.dart';

class SliverHeaderWidget extends SliverPersistentHeaderDelegate {
  final String title;

  SliverHeaderWidget({
    required this.title,
  });

  @override
  double get minExtent => 50;

  @override
  double get maxExtent => 50;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(
      child: Container(
        color: Theme.of(context).colorScheme.background,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(SliverHeaderWidget oldDelegate) {
    return false;
  }
}

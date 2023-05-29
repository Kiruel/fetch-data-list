import 'package:flutter/widgets.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

extension ListViewRefreshable on ListView {
  Widget refreshable(Future<void> Function() onRefresh) => RefreshableWidget(
        builder: (refreshController) => SmartRefresher(
          controller: refreshController,
          onRefresh: () async {
            await onRefresh.call();
            refreshController.refreshCompleted();
          },
          child: this,
        ),
      );
}

class RefreshableWidget extends StatefulWidget {
  const RefreshableWidget({super.key, required this.builder});
  final Widget Function(RefreshController refreshController) builder;
  @override
  State<RefreshableWidget> createState() => _RefreshableWidgetState();
}

class _RefreshableWidgetState extends State<RefreshableWidget> {
  final RefreshController refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return widget.builder(refreshController);
  }
}

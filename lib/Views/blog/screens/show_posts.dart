import 'package:ecommerceApp/Views/blog/view_models/show_posts_view_model.dart';
import 'package:ecommerceApp/Views/blog/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:stacked/stacked.dart';

class ShowPostsScreen extends StatelessWidget {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PostsViewModel>.reactive(
        viewModelBuilder: () => PostsViewModel(),
        onModelReady: (model) {
          model.fetchMorePosts();
        },
        builder: (context, model, child) {
          return Scaffold(
            backgroundColor: Colors.grey.shade100,
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
                    model.navigationService.goBack();
                  },
                  icon: Icon(
                    CupertinoIcons.left_chevron,
                    size: 30,
                  ),
                ),
                title: Text("Posts"),
                elevation: 0,
              ),
              body: SizedBox.expand(
                child: SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: true,
                  controller: _refreshController,
                  header: ClassicHeader(),
                  footer: ClassicFooter(),
                  onRefresh: () async {
                    await model.fetchMorePosts();
                    _refreshController.refreshCompleted();
                  },
                  onLoading: () async {
                      await model.fetchMorePosts() ;
                    _refreshController.loadComplete();
                  },
                  child: ListView.builder(
                    padding: EdgeInsets.all(16),
                    itemBuilder: (context, index) {
                      print(model.posts[index]);

                      return PostVerticalWidget(model.posts[index]);
                    },
                    itemCount: model.posts.length,
                  ),
                ),
              ));
        });
  }
}

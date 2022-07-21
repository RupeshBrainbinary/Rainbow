import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rainbow/common/popup.dart';
import 'package:rainbow/model/StoryComment_model.dart';
import 'package:rainbow/model/likeStory_model.dart';
import 'package:rainbow/model/unlike_model.dart';
import 'package:rainbow/screens/Home/Story/friendStory_api/friendStory_model.dart';
import 'package:rainbow/screens/Home/Story/likeStory_api/likeStory_api.dart';
import 'package:rainbow/screens/Home/Story/unlike_api/unlike_api.dart';
import 'package:rainbow/screens/Home/home_controller.dart';
import 'package:rainbow/screens/Home/my_story/api/myStroy_api.dart';
import 'package:rainbow/screens/Home/story_commets/api/story_comment_api.dart';
import 'package:rainbow/screens/Home/story_commets/story_comments_screen.dart';
import 'package:rainbow/screens/Home/story_commets/story_commets_controller.dart';
import 'package:rainbow/screens/Home/view_story/widgets/likes_bottomShit.dart';
import 'package:story/story_page_view/story_page_view.dart';

import '../../../model/friendStroy_model.dart';
import '../../../model/myStory_model.dart';

class ViewStoryController extends GetxController {
  RxBool loader = false.obs;
  FriendStoryModel friendStoryModel = FriendStoryModel();
  MyStoryModel myStoryModel = MyStoryModel();
  UnLikeStoryModel unLikeStoryModel = UnLikeStoryModel();
  LikeStoryModel likeStoryModel = LikeStoryModel();
  StoryCommentModel storyCommentModel = StoryCommentModel();
  TextEditingController writeSomethings = TextEditingController();
  late ValueNotifier<IndicatorAnimationCommand> indicatorAnimationController;
  List<UserDetail> storyLikesList = [];
  int currentPage = 0;
  int storyIndex = 0;

  void init() {
    friendStoryApiData();
  }

  @override
  void onInit() {
    super.onInit();
  }

  void onStoryComplete() {}

  void onBackTap() {
    Get.back();
  }

  void onMoreBtnTap() {}

  void onHashTagTap() {}

  void onLikeBtnTap(id) {
    likeStory(id);
    // update(["friendStory"]);
  }

  void onUnLikeBtnTap(id) {
    unLikeStory(id);
    // update(["friendStory"]);
  }

  bool validation() {
    if (writeSomethings.text.isEmpty) {
      errorToast("Type Something");
      return false;
    }
    return true;
  }

  void onLikeViewTap(
      {required FriendStory friendStory, required int storyIndex}) {
    indicatorAnimationController.value = IndicatorAnimationCommand.pause;
    storyLikesList = friendStory.storyList![storyIndex].storyLikeList ?? [];
    Get.bottomSheet(
      LikesBottomShit(),
      isScrollControlled: true,
    ).then((value) {
      indicatorAnimationController.value = IndicatorAnimationCommand.resume;
    });
  }

  Future<void> friendStoryApiData() async {
    try {
      loader.value = true;
      friendStoryModel = (await FriendStoryApi.postRegister())!;
      update(["adStory"]);
      HomeController homeController = Get.find();
      homeController.update(['home']);
      onPageChange(currentPage);

      loader.value = false;
    } catch (e) {
      loader.value = false;
    }
  }

  Future<void> likeStory(String id) async {
    try {
      loader.value = true;
      indicatorAnimationController.value = IndicatorAnimationCommand.pause;
      likeStoryModel = await LikeStoryApi.postRegister(id);
      indicatorAnimationController.value = IndicatorAnimationCommand.resume;
      await friendStoryApiData();
      update(["friendStory"]);
      loader.value = false;
    } catch (e) {
      loader.value = false;
    }
  }

  Future<void> unLikeStory(String id) async {
    try {
      loader.value = true;
      indicatorAnimationController.value = IndicatorAnimationCommand.pause;
      unLikeStoryModel = await UnLikeStoryApi.postRegister(id);
      await friendStoryApiData();
      indicatorAnimationController.value = IndicatorAnimationCommand.resume;
      update(["friendStory"]);

      loader.value = false;
    } catch (e) {
      loader.value = false;
    }
  }

  Future<void> commentData(String id) async {
    try {
      loader.value = true;
      storyCommentModel = (await StoryCommentApi.sendNewComment(
              id, writeSomethings.text.toString()) ??
          StoryCommentModel());
      await friendStoryApiData();
      update(["friendStory"]);
      writeSomethings.clear();
      loader.value = false;
    } catch (e) {
      loader.value = false;
    }
  }

  Future<void> onCommentButtonTap(
      {required FriendStory friendStory, required int storyIndex}) async {
    indicatorAnimationController.value = IndicatorAnimationCommand.pause;
    await friendStoryApiData();
    StoryCommentsController storyController =
        Get.put(StoryCommentsController());
    storyController.comments =
        friendStory.storyList![storyIndex].storyCommentList ?? [];
    Get.to(() => StoryCommentsScreen())!.whenComplete(() {
      indicatorAnimationController.value = IndicatorAnimationCommand.resume;
    });
  }

  void commentSendTap(String id, BuildContext context) {
    if (validation()) {
      indicatorAnimationController.value = IndicatorAnimationCommand.pause;
      commentData(id);
      update(["friendStory"]);
      FocusScope.of(context).unfocus();
    }
  }

  void onPageChange(int pageIndex) {
    currentPage = pageIndex;
    onStoryChange(pageIndex, 0);
  }

  void onStoryChange(int pageIndex, int storyIndex) {
    currentPage = pageIndex;
    this.storyIndex = storyIndex;
    viewStoryApi();
  }

  Future<void> viewStoryApi() async {
    String storyId = friendStoryModel
        .data![currentPage].storyList![storyIndex].id
        .toString();
    await MyStoryApi.storyViewAPi(storyId);
  }
}

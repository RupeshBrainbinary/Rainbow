import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rainbow/common/blocList_api/blockList_api.dart';
import 'package:rainbow/common/helper.dart';
import 'package:rainbow/common/popup.dart';
import 'package:rainbow/model/blockList_model.dart';
import 'package:rainbow/model/friendPostView_Model.dart';
import 'package:rainbow/model/listOfFriendRequest_model.dart';
import 'package:rainbow/model/myPostList_model.dart';
import 'package:rainbow/model/postLike_model.dart';
import 'package:rainbow/model/postView_model.dart';
import 'package:rainbow/model/sharePost_model.dart';
import 'package:rainbow/model/unLikePost_model.dart';
import 'package:rainbow/screens/Home/Story/friendStory_api/friendStory_api.dart';
import 'package:rainbow/screens/Home/Story/story_controller.dart';
import 'package:rainbow/screens/Home/addStroy/addStory_screen.dart';
import 'package:rainbow/screens/Home/myPost_Api/myPost_api.dart';
import 'package:rainbow/screens/Home/my_story/api/myStroy_api.dart';
import 'package:rainbow/screens/Home/my_story/my_story_controller.dart';
import 'package:rainbow/screens/Home/my_story/my_story_screen.dart';
import 'package:rainbow/screens/Home/view_story/view_story_controller.dart';
import 'package:rainbow/screens/Home/view_story/view_story_screen.dart';
import 'package:rainbow/screens/Profile/profile_controller.dart';
import 'package:rainbow/screens/Profile/widget/listOfFriendRequest_api/listOfFriendRequest_api.dart';
import 'package:rainbow/screens/auth/register/list_nationalites/list_nationalites_api.dart';
import 'package:rainbow/screens/auth/registerfor_adviser/listOfCountry/listOfCountryApi.dart';
import 'package:rainbow/screens/notification/notification_controller.dart';
import 'package:rainbow/screens/notification/notification_screen.dart';

class HomeController extends GetxController {
  RxBool loader = false.obs;
  ProfileController controller = Get.put(ProfileController());
  ListOfFriendRequestModel listOfFriendRequestModel =
      ListOfFriendRequestModel();
  ViewStoryController viewStoryController = Get.put(ViewStoryController());
  List<bool> isAd = List.generate(10, (index) => Random().nextInt(2) == 1);
  MyStoryController myStoryController = Get.put(MyStoryController());
  RefreshController? refreshController;
  NotificationsController notificationsController = Get.put(NotificationsController());
  MyPostListModel myPostListModel=MyPostListModel();


  @override
  Future<void> onInit() async {
    init();
    super.onInit();
  }

  final storyController = EditStoryController();

  Future<void> countryName() async {
    try {
      await ListOfCountryApi.postRegister()
          .then((value) => listCountryModel = value!);
      debugPrint(listCountryModel.toJson().toString());
      getCountry();
    } catch (e) {
      errorToast(e.toString());
      debugPrint(e.toString());
    }
  }

  void onNewStoryTap() {
    // if (myStoryController.myStoryModel.data!.isNotEmpty) {
    Get.to(() => const MyStoryScreen());
    /*   } else {
      Get.to(() => AddStoryScreen());
    }*/
    // Get.to(() => AddStoryScreen());
  }

  Future<void> countryNationalites() async {
    try {
      await ListOfNationalitiesApi.postRegister()
          .then((value) => listNationalities = value!);
      print(listNationalities);
      getCountryNation();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  BlockListModel blockListModel = BlockListModel();

  Future<void> blockListDetailes() async {
    try {
      await BlockListApi.postRegister()
          .then((value) => blockListModel = value!);
      print(blockListModel);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
  Future<void> myStoryList() async {
    try {
      myPostListModel = await FriendStoryApi.getMyPostList();
      update(['home']);

    } catch (e) {
      debugPrint(e.toString());
    }
  }
  SharePostModel sharePostModel =SharePostModel();
  Future<void> sharePostData(String id) async {
    try {
      sharePostModel = await MyPostApi.sharPostApi(id);
      update(['home']);

    } catch (e) {
      debugPrint(e.toString());
    }
  }
  PostLikeModel postLikeModel =PostLikeModel();
  Future<void> likePostData(String id) async {
    try {
      loader.value = true;
      postLikeModel = await MyPostApi.postLikeApi(id);
      update(['home']);
      loader.value = false;
    } catch (e) {
      loader.value = false;
      debugPrint(e.toString());
    }
  }
  PostUnlikeModel postUnlikeModel = PostUnlikeModel();
  Future<void> unLikePostData(String id) async {
    try {
      postUnlikeModel = await MyPostApi.postUnLikeApi(id);
      update(['home']);

    } catch (e) {
      debugPrint(e.toString());
    }
  }
  PostViewModel postViewModel =PostViewModel();
  Future<void> postViewData(String id) async {
    try {
      postViewModel = await MyPostApi.postViewApi(id);
      update(['home']);

    } catch (e) {
      debugPrint(e.toString());
    }
  }
  FriendPostViewModel friendPostViewModel = FriendPostViewModel();
  Future<void> friendPostData() async {
    try {
      friendPostViewModel = await MyPostApi.friendPostApi();
      update(['home']);

    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> listOfFriedRequestDetails() async {
    try {
      changeLoader(true);
      listOfFriendRequestModel = (await ListOfFriendRequestApi.postRegister())!;
      update(["connections"]);
      changeLoader(false);
    } catch (e) {
      changeLoader(false);
    }
  }

  Future<void> init() async {
    changeLoader(true);
    countryName();
    countryNationalites();
    // await blockListDetailes();
    // await listOfFriedRequestDetails();
    await controller.viewProfileDetails();
    await onStory();
    notificationsController.getNotifications();
    changeLoader(false);
    await myStoryList();
    // viewStoryController.friendStoryApiData();
    // loader.value = true;
  }

  Future<void> onStory() async {
    await viewStoryController.friendStoryApiData();
    await myStoryController.init();
    update(['home']);
  }

  Future<void> myStoryOnTap() async {
    Get.to(() => AddStoryScreen());
    /*MyStoryController myStoryController = Get.put(MyStoryController());
    loader.value = true;
    await myStoryController.init();
    loader.value = false;
    if (myStoryController.myStoryModel.data!.isNotEmpty) {
      Get.to(() => const MyStoryScreen());
    } else {
      Get.to(() => AddStoryScreen());
    }*/
  }

  Future<void> onRefresh() async {
    await init();
    refreshController!.refreshCompleted();
  }

  void changeLoader(bool status) {
    if(refreshController == null || refreshController!.headerMode == null){
      loader.value = status;
      return;
    }
    if (refreshController!.headerMode!.value == RefreshStatus.refreshing) {
      return;
    }
    loader.value = status;
  }

  void onNotyIconBtnTap(){
    NotificationsController notificationsController = Get.put(NotificationsController());
    notificationsController.init();
    Get.to(() => NotificationScreen());
  }

  Future<void> onFriedStoryTap(int index) async {
    viewStoryController.currentPage = index;
    viewStoryController.storyIndex = 0;
    viewStoryController.init();
    /*loader.value = true;
    for (var data in viewStoryController.friendStoryModel.data!) {
      for (var story in data.storyList!) {
        String url = story.storyItem.toString();
        await DefaultCacheManager().downloadFile(url);
      }
    }
    loader.value = false;*/
    Get.to(() => const ViewStoryScreen());
  }
}

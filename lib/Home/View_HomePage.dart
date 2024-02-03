import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/appbar.dart';

//유저 유형
enum UserType { me, parent, educator, friend }

// 유저 객체
class User {
  final String name;
  final String message;
  final UserType userType;
  final RxBool isPanelOpen = true.obs;

  User({required this.name, required this.message, required this.userType});
}

//유저 리스트
final List<User> users = [
  User(name: '나', message: '푸름푸름', userType: UserType.me),
  User(name: '엄마', message: 'ㅎㅇ', userType: UserType.parent),
  User(name: '학원쌤', message: '숙제 ㄱㄱ', userType: UserType.educator),
  User(name: '철수', message: '인생 고달프다', userType: UserType.friend),
  User(name: '훈이', message: '상남자다', userType: UserType.friend),
  User(name: '아빠', message: 'ㅃ2', userType: UserType.parent),
  User(name: '담임', message: '담임입니다.예', userType: UserType.educator),
];

// 유저를 유형별로 정리
String getUserTypeText(UserType userType) {
  switch (userType) {
    case UserType.me:
      return '나';
    case UserType.parent:
      return '부모님';
    case UserType.educator:
      return '관계자';
    case UserType.friend:
      return '친구';
  }
}

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(),
      body: CustomScrollView(
        slivers: <Widget>[
          for (var user in users)
            SliverToBoxAdapter(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      //접었다 폈다
                      user.isPanelOpen.value = !user.isPanelOpen.value;
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            getUserTypeText(user.userType),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                          Obx(
                            () => Icon(
                              user.isPanelOpen.value
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Obx(
                    () => Visibility(
                      visible: user.isPanelOpen.value,
                      child: UserListView(
                        user: user,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class UserListView extends StatelessWidget {
  final User user;

  UserListView({required this.user});

  @override
  Widget build(BuildContext context) {
    Widget leadingWidget;
    switch (user.userType) {
      case UserType.me:
        leadingWidget = CircleAvatar(
          child: Icon(Icons.person),
        );
        break;
      case UserType.parent:
        leadingWidget = CircleAvatar(
          child: Icon(Icons.family_restroom),
        );
        break;
      case UserType.educator:
        leadingWidget = CircleAvatar(
          child: Icon(Icons.school),
        );
        break;
      case UserType.friend:
        leadingWidget = CircleAvatar(
          child: Icon(Icons.favorite),
        );
        break;
      default:
        leadingWidget = CircleAvatar(
          child: Icon(Icons.person),
        );
    }
    return Column(
      children: [
        ListTile(
          leading: leadingWidget,
          title: Text(user.name),
          subtitle: Text(user.message),
          onTap: () {
            // 사용자 클릭 시 이벤트 추가 필요
          },
        ),
      ],
    );
  }
}

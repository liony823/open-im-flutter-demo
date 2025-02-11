import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:openim_common/openim_common.dart';

import '../contacts/contacts_view.dart';
import '../conversation/conversation_view.dart';
import '../mine/mine_view.dart';
import '../applet/applet_view.dart';
import '../feed/feed_view.dart';
import 'home_logic.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

class HomePage extends StatelessWidget {
  final logic = Get.find<HomeLogic>();
  HomePage({super.key});

  List<PersistentTabConfig> _buildTabs() => [
        PersistentTabConfig(
          screen: ConversationPage(),
          item: ItemConfig(
            icon: GestureDetector(
              onDoubleTap: () {
                logic.scrollToUnreadMessage();
              },
              child: _setupIcon(
                  _buildIcon(EvaIcons.messageCircle, Styles.c_0089FF),
                  logic.unreadMsgCount.value),
            ),
            inactiveIcon: _setupIcon(
                _buildIcon(EvaIcons.messageCircleOutline, Styles.c_8E9AB0),
                logic.unreadMsgCount.value),
            title: StrRes.home,
            textStyle: Styles.ts_0089FF_10_semibold,
          ),
        ),
        PersistentTabConfig(
          screen: ContactsPage(),
          item: ItemConfig(
            icon: _setupIcon(_buildIcon(EvaIcons.people, Styles.c_0089FF),
                logic.unhandledCount.value),
            inactiveIcon: _setupIcon(
                _buildIcon(EvaIcons.peopleOutline, Styles.c_8E9AB0),
                logic.unhandledCount.value),
            title: StrRes.contacts,
            textStyle: Styles.ts_0089FF_10_semibold,
          ),
        ),
        PersistentTabConfig(
          screen: AppletPage(),
          item: ItemConfig(
            icon: _buildIcon(EvaIcons.globe, Styles.c_0089FF),
            inactiveIcon: _buildIcon(EvaIcons.globe2Outline, Styles.c_8E9AB0),
            title: StrRes.miniProgram,
            textStyle: Styles.ts_0089FF_10_semibold,
          ),
        ),
        PersistentTabConfig(
          screen: FeedPage(),
          item: ItemConfig(
            icon: _buildIcon(EvaIcons.compass, Styles.c_0089FF),
            inactiveIcon: _buildIcon(EvaIcons.compassOutline, Styles.c_8E9AB0),
            title: StrRes.feed,
            textStyle: Styles.ts_0089FF_10_semibold,
          ),
        ),
        PersistentTabConfig(
          screen: MinePage(),
          item: ItemConfig(
            icon: _buildIcon(EvaIcons.person, Styles.c_0089FF),
            inactiveIcon: _buildIcon(EvaIcons.personOutline, Styles.c_8E9AB0),
            title: StrRes.mine,
            textStyle: Styles.ts_0089FF_10_semibold,
          ),
        )
      ];

  Icon _buildIcon(IconData icon, Color color) {
    return Icon(
      icon,
      size: 24,
      color: color,
    );
  }

  Widget _setupIcon(Widget icon, int unReadCount) {
    return Stack(
      alignment: Alignment.center,
      children: [
        icon,
        Positioned(
          top: 0,
          right: 0,
          child: Transform.translate(
            offset: const Offset(2, -2),
            child: UnreadCountView(count: unReadCount),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => PersistentTabView(
          controller: logic.tabController,
          tabs: _buildTabs(),
          navBarBuilder: (navBarConfig) => Style1BottomNavBar(
            navBarConfig: navBarConfig,
            navBarDecoration: const NavBarDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black12, blurRadius: 0.5, spreadRadius: 0.5),
              ],
            ),
          ),
          navBarOverlap: const NavBarOverlap.none(),
          screenTransitionAnimation: const ScreenTransitionAnimation.none(),
        ));
  }
}

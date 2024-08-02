import 'package:aiquaboost/data/chatting_list_data.dart';
import 'package:aiquaboost/screens/chatting_screen/chatting_page.dart';
import 'package:aiquaboost/screens/chatting_screen/components/chatting_list_component.dart';
import 'package:aiquaboost/screens/user_profile.dart';
import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  static const id = 'Chats';
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    print(ChattingServicesData().getChattingListStreamRealtimeDatabaseTemp(
        userID: Profile.userInfoData!.userID));
    return StreamBuilder(
        stream: ChattingServicesData()
            .getChattingListStreamRealtimeDatabaseTemp(
                userID: Profile.userInfoData!.userID),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Icon(
                Icons.error_outline,
                color: Colors.grey,
                size: 200,
              ),
            );
          }

          // if (snapshot.connectionState == ConnectionState.waiting) {
          //   return const Center(
          //     child: SpinKitFadingCircle(
          //       color: Color.fromRGBO(2, 62, 138, 1),
          //       size: 100,
          //     ),
          //   );
          // }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            print('StreamBuilder has no data');
            return const Center(
              child: Icon(
                Icons.do_not_disturb_alt_outlined,
                color: Colors.grey,
                size: 200,
              ),
            );
          }

          return ListView(
            children: snapshot.data!
                .map<Widget>((chattingListData) =>
                    _buildChattingListItem(chattingListData, context))
                .toList(),
          );
        });
  }

  Widget _buildChattingListItem(
      Map<String, dynamic> chatListData, BuildContext context) {
    print(chatListData);
    return ChatListTile(
      profileUrl: chatListData['user_profile_photo'],
      name: chatListData['full_name'],
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChattingPage(
              freindUserName: chatListData['full_name'],
              friendUserProfilePhoto: chatListData['user_profile_photo'],
              friendUserId: chatListData['userID'],
            ),
          ),
        );
      },
    );
  }
}

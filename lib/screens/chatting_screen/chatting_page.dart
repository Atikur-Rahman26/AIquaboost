import 'package:aiquaboost/constants.dart';
import 'package:aiquaboost/data/chatting_list_data.dart';
import 'package:aiquaboost/screens/chatting_screen/chat_bubble.dart';
import 'package:aiquaboost/screens/user_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ChattingPage extends StatefulWidget {
  final String friendUserId;
  final String freindUserName;
  final String friendUserProfilePhoto;

  ChattingPage({
    super.key,
    required this.friendUserId,
    required this.freindUserName,
    required this.friendUserProfilePhoto,
  });

  @override
  _ChattingPageState createState() => _ChattingPageState();
}

class _ChattingPageState extends State<ChattingPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChattingServicesData _chattingServicesData = ChattingServicesData();
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;
  final ScrollController _scrollController = ScrollController();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = pickedFile;
    });
  }

  void _sendMessage() async {
    if (_messageController.text.isNotEmpty || _imageFile != null) {
      String imageUrl = 'N';
      bool uploadedPhoto = false;
      if (_imageFile != null) {
        uploadedPhoto = true;
        imageUrl = _imageFile!.path;
      }

      await _chattingServicesData.sendMessage(
        receiverId: widget.friendUserId,
        message: _messageController.text,
        image: imageUrl,
        uploadedPhoto: uploadedPhoto,
      );
      _messageController.clear();
      setState(() {
        _imageFile = null;
      });
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: buildAppBar(
          widget.friendUserProfilePhoto,
          widget.freindUserName,
          context,
        ),
        body: Column(
          children: [
            Expanded(child: _buildMessageList()),
            _buildUserInput(),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageList() {
    String senderID = Profile.userInfoData!.userID;
    return StreamBuilder(
      stream: _chattingServicesData.getMessagesStream(
          senderID, widget.friendUserId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: Icon(
              Icons.hourglass_empty,
              size: 200,
              color: Colors.grey,
            ),
          );
        }

        WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());

        return ListView(
          controller: _scrollController,
          children:
              snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
        );
      },
    );
  }

  Widget _buildUserInput() {
    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.photo),
          onPressed: _pickImage,
        ),
        Expanded(
          child: TextField(
            controller: _messageController,
            decoration: const InputDecoration(
              hintText: "Type a message",
            ),
            onTap: () {
              _scrollToBottom();
            },
          ),
        ),
        IconButton(
          icon: Icon(Icons.send),
          onPressed: _sendMessage,
        ),
      ],
    );
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final isMe = data['sender_ID'] == Profile.userInfoData!.userID;

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: ChatBubble(
        message: data['message'],
        imageUrl: data['message_photo'] == 'N' ? null : data['message_photo'],
        isMe: isMe,
      ),
    );
  }

  AppBar buildAppBar(String friendUserProfilePhoto, String freindUserName,
      BuildContext context) {
    return AppBar(
      backgroundColor: kPrimaryBlueColor,
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context); // Go back
        },
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 24.0, // Customize size
          ),
        ),
      ),
      title: Row(
        children: [
          CircleAvatar(
            radius: 20.0,
            backgroundImage: NetworkImage(friendUserProfilePhoto),
            onBackgroundImageError: (_, __) => const Icon(
              Icons.person_outline_sharp,
              color: Colors.grey,
              size: 20,
            ),
            child:
                Container(), // To avoid a blank avatar if the image fails to load
          ),
          const SizedBox(width: 10.0),
          Text(
            freindUserName,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}

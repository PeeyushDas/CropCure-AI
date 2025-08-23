import 'package:flutter/material.dart';
import 'package:rice_app/config/app_constants.dart';
import 'package:rice_app/config/size_config.dart';
import 'package:rice_app/services/gemini_service.dart';

class ChatScreen extends StatefulWidget {
  final String diseaseName;
  final String cropName;

  const ChatScreen({
    Key? key,
    required this.diseaseName,
    required this.cropName,
  }) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = [];
  final ScrollController _scrollController = ScrollController();
  final GeminiService _geminiService = GeminiService();

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() async {
    if (_messageController.text.trim().isEmpty) return;

    final userMessage = _messageController.text;

    setState(() {
      _messages.add(ChatMessage(message: userMessage, isUser: true));
      _messageController.clear();
    });

    // Show typing indicator
    setState(() {
      _messages.add(ChatMessage(message: "Typing...", isUser: false));
    });

    try {
      final response = await _geminiService.getChatResponse(
        userMessage,
        widget.diseaseName,
        widget.cropName,
      );

      setState(() {
        // Remove typing indicator
        _messages.removeLast();
        // Add AI response
        _messages.add(ChatMessage(message: response, isUser: false));
      });
    } catch (e) {
      setState(() {
        // Remove typing indicator
        _messages.removeLast();
        // Add error message
        _messages.add(
          ChatMessage(
            message: "Sorry, there was an error generating the response.",
            isUser: false,
          ),
        );
      });
    }

    _scrollToBottom();
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

  List<TextSpan> _parseText(String text) {
    List<TextSpan> spans = [];
    RegExp exp = RegExp(r'\*\*(.*?)\*\*');
    int lastMatch = 0;

    for (Match match in exp.allMatches(text)) {
      // Add text before the match
      if (match.start > lastMatch) {
        spans.add(
          TextSpan(
            text: text.substring(lastMatch, match.start),
            style: TextStyle(
              color: Colors.white,
              fontSize: SizeConfig.textMultiplier * 1.8,
            ),
          ),
        );
      }

      // Add the bold text (without **)
      spans.add(
        TextSpan(
          text: match.group(1), // This gets just the text between **
          style: TextStyle(
            color: Colors.white,
            fontSize: SizeConfig.textMultiplier * 1.8,
            fontWeight: FontWeight.bold,
          ),
        ),
      );

      lastMatch = match.end;
    }

    // Add any remaining text
    if (lastMatch < text.length) {
      spans.add(
        TextSpan(
          text: text.substring(lastMatch),
          style: TextStyle(
            color: Colors.white,
            fontSize: SizeConfig.textMultiplier * 1.8,
          ),
        ),
      );
    }

    return spans;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // Add this line
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'AI Assistant',
              style: TextStyle(
                fontSize: SizeConfig.textMultiplier * 2.2,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Disease: ${widget.diseaseName}',
              style: TextStyle(
                fontSize: SizeConfig.textMultiplier * 1.6,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        backgroundColor: AppConstants.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        // Wrap the body with SafeArea
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppConstants.primaryColor.withOpacity(0.1),
                      Colors.white,
                    ],
                  ),
                ),
                child: ListView.builder(
                  controller: _scrollController,
                  padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 4),
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    return _buildMessageBubble(_messages[index]);
                  },
                ),
              ),
            ),
            SafeArea(
              // Add SafeArea here as well
              child: _buildMessageInput(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: SizeConfig.blockSizeVertical * 1,
          horizontal: SizeConfig.blockSizeHorizontal * 2,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.blockSizeHorizontal * 4,
          vertical: SizeConfig.blockSizeVertical * 1.5,
        ),
        decoration: BoxDecoration(
          color:
              message.isUser
                  ? AppConstants.primaryColor
                  : AppConstants.secondaryColor,
          borderRadius: BorderRadius.circular(15),
        ),
        constraints: BoxConstraints(maxWidth: SizeConfig.screenWidth * 0.75),
        child: RichText(text: TextSpan(children: _parseText(message.message))),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 4),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, -1),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Type your message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[100],
                contentPadding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.blockSizeHorizontal * 4,
                  vertical: SizeConfig.blockSizeVertical * 1,
                ),
              ),
              maxLines: null,
              textInputAction: TextInputAction.send,
              onSubmitted: (_) => _sendMessage(),
            ),
          ),
          SizedBox(width: SizeConfig.blockSizeHorizontal * 2),
          Container(
            decoration: BoxDecoration(
              color: AppConstants.primaryColor,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(Icons.send, color: Colors.white),
              onPressed: _sendMessage,
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMessage {
  final String message;
  final bool isUser;

  ChatMessage({required this.message, required this.isUser});
}

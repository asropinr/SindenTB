import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sinden_tb_app/controller/faq_controller.dart';
import 'package:sinden_tb_app/model/pusatbantuan/get_chatbox_model.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatItem {
  final String text;
  final bool isUser;
  List<dynamic> options;
  List<Citations> citations;

  ChatItem({
    required this.text,
    required this.isUser,
    this.options = const [],
    this.citations = const [],
  });
}

class HealthAssistantScreen extends StatefulWidget {
  const HealthAssistantScreen({super.key});

  @override
  State<HealthAssistantScreen> createState() => _HealthAssistantScreenState();
}

class _HealthAssistantScreenState extends State<HealthAssistantScreen> {
  final FaqController faqController = Get.find<FaqController>();

  final ScrollController scrollController = ScrollController();

  List<ChatItem> messages = [];

  bool isTyping = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadRoot();
  }

  Future<void> loadRoot() async {
    setState(() {
      isLoading = true;
    });

    await faqController.getChatBox(
      "menu_utama",
    );

    final data = faqController.getChatBoxModel?.data;

    if (data != null) {
      messages.add(
        ChatItem(
          text: data.text ?? "",
          isUser: false,
          options: data.options ?? [],
          citations: data.citations ?? [],
        ),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<void> selectOption(
    dynamic option,
  ) async {
    final lastBotIndex = messages.lastIndexWhere(
      (e) => !e.isUser,
    );

    if (lastBotIndex != -1) {
      messages[lastBotIndex].options = [];
    }

    setState(() {
      messages.add(
        ChatItem(
          text: option.label ?? "",
          isUser: true,
        ),
      );

      isTyping = true;
    });

    scrollToBottom();

    // supaya typing sempat terlihat
    await Future.delayed(
      const Duration(milliseconds: 800),
    );

    await faqController.getChatBox(
      option.nextStepId,
    );

    final data = faqController.getChatBoxModel?.data;
    if (data?.actionUrl != null && data!.actionUrl!.isNotEmpty) {
      final uri = Uri.parse(data.actionUrl!);

      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    }

    setState(() {
      isTyping = false;

      if (data != null) {
        messages.add(
          ChatItem(
            text: data.text ?? "",
            isUser: false,
            options: data.options ?? [],
            citations: data.citations ?? [],
          ),
        );
      }
    });

    scrollToBottom();
  }

  void scrollToBottom() {
    Future.delayed(
      const Duration(milliseconds: 200),
      () {
        if (scrollController.hasClients) {
          scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            duration: const Duration(
              milliseconds: 300,
            ),
            curve: Curves.easeOut,
          );
        }
      },
    );
  }

  bool isResultMessage(String text) {
    return text.contains("HASIL:");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: const Color(0xFFF6F8FB),
        appBar: AppBar(
          title: const Text(
            "Health Assistant",
          ),
          centerTitle: true,
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                controller: scrollController,
                padding: const EdgeInsets.all(16),
                itemCount: messages.length + (isTyping ? 1 : 0),
                itemBuilder: (context, index) {
                  if (isTyping && index == messages.length) {
                    return _typingBubble();
                  }

                  final message = messages[index];

                  final isResult = isResultMessage(
                    message.text,
                  );

                  return Column(
                    crossAxisAlignment: message.isUser
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: message.isUser
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          constraints: const BoxConstraints(
                            maxWidth: 320,
                          ),
                          margin: const EdgeInsets.only(
                            bottom: 8,
                          ),
                          padding: const EdgeInsets.all(
                            14,
                          ),
                          decoration: BoxDecoration(
                            color: message.isUser
                                ? Colors.green
                                : isResult
                                    ? const Color(
                                        0xFFFFF4E5,
                                      )
                                    : Colors.white,
                            borderRadius: BorderRadius.circular(
                              18,
                            ),
                            border: isResult
                                ? Border.all(
                                    color: Colors.orange,
                                    width: 1.2,
                                  )
                                : null,
                          ),
                          child: Text(
                            message.text,
                            style: TextStyle(
                              color: message.isUser
                                  ? Colors.white
                                  : Colors.black87,
                              fontSize: 14,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ),
                      if (!message.isUser && message.options.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 16,
                          ),
                          child: Column(
                            children: message.options.map<Widget>(
                              (option) {
                                return Container(
                                  width: double.infinity,
                                  margin: const EdgeInsets.only(
                                    bottom: 8,
                                  ),
                                  child: OutlinedButton(
                                    onPressed: () {
                                      selectOption(
                                        option,
                                      );
                                    },
                                    style: OutlinedButton.styleFrom(
                                      alignment: Alignment.centerLeft,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 14,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          12,
                                        ),
                                      ),
                                    ),
                                    child: Text(
                                      option.label ?? "",
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                );
                              },
                            ).toList(),
                          ),
                        ),
                      if (!message.isUser && message.citations.isNotEmpty)
                        _citationList(message.citations),
                    ],
                  );
                },
              ),
      ),
    );
  }

  Widget _citationList(List<Citations> citations) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(
        bottom: 16,
      ),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.shade300,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Sumber informasi",
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          ...citations.map(
            (citation) {
              return InkWell(
                onTap: () async {
                  if (citation.fileUrl == null || citation.fileUrl!.isEmpty) {
                    return;
                  }

                  final uri = Uri.tryParse(
                    citation.fileUrl!,
                  );

                  if (uri != null) {
                    await launchUrl(
                      uri,
                      mode: LaunchMode.externalApplication,
                    );
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 6,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.article_outlined,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              citation.title ?? "Untitled",
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            if (citation.publisher != null)
                              Text(
                                citation.publisher!,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.open_in_new,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _typingBubble() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(
          bottom: 12,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            18,
          ),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 14,
              height: 14,
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            ),
            SizedBox(width: 10),
            Text(
              "Sedang mengetik...",
            ),
          ],
        ),
      ),
    );
  }
}

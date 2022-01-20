import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gocery/core/config/app_const.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chat')),
      body: ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.all(kMediumPadding),
        itemCount: 10,
        separatorBuilder: (context, index) =>
            const Divider(color: Colors.transparent),
        itemBuilder: (context, index) {
          return Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            child: InkWell(
              onTap: () {
                Get.toNamed(kChatDetailPage);
              },
              borderRadius: BorderRadius.circular(10),
              child: Ink(
                padding: const EdgeInsets.all(kMediumPadding),
                decoration: BoxDecoration(
                  color: kLightColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: kLightColor50),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipOval(
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://loremflickr.com/350/350/vegetable,fruit?random=1',
                        width: 50,
                      ),
                    ),
                    const SizedBox(width: kMediumPadding),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Bejo',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Get.theme.textTheme.bodyText1,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Sesuai pesanan ya pak asdasda',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Get.theme.textTheme.bodyText2,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: kMediumPadding),
                    Text(
                      '21:08',
                      style: Get.theme.textTheme.bodyText2
                          ?.copyWith(fontSize: kSmallFont),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

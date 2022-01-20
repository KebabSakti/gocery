import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gocery/core/config/app_const.dart';
import 'package:gocery/core/utility/mtoast.dart';

class ChatDetailPage extends StatelessWidget {
  const ChatDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Bang jago'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: CircleAvatar(
              radius: 18,
              backgroundImage: CachedNetworkImageProvider(
                  'https://www.hollywoodreporter.com/wp-content/uploads/2012/05/brad_pitt_chanel_a_p.jpg'),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          ListView.separated(
            itemCount: 20,
            padding: const EdgeInsets.only(
              left: 15,
              right: 15,
              top: 15,
              bottom: 65,
            ),
            separatorBuilder: (context, index) => const Divider(
              height: 10,
              thickness: 0,
              color: Colors.transparent,
            ),
            itemBuilder: (context, index) {
              return Row(
                mainAxisAlignment: (index.isEven)
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
                children: [
                  Material(
                    child: InkWell(
                      onLongPress: () {
                        Clipboard.setData(const ClipboardData(
                            text: 'Hallo, pesanan sesuai aplikasi ya'));

                        MToast.show('Text copied');
                      },
                      borderRadius: BorderRadius.only(
                        topRight: (index.isEven)
                            ? const Radius.circular(2)
                            : const Radius.circular(10),
                        topLeft: (index.isEven)
                            ? const Radius.circular(10)
                            : const Radius.circular(2),
                        bottomLeft: const Radius.circular(10),
                        bottomRight: const Radius.circular(10),
                      ),
                      child: Ink(
                        padding: const EdgeInsets.all(kMediumPadding),
                        width: Get.size.width / 1.5,
                        decoration: BoxDecoration(
                          color: (index.isEven) ? kPrimaryColor : kLightColor,
                          borderRadius: BorderRadius.only(
                            topRight: (index.isEven)
                                ? const Radius.circular(2)
                                : const Radius.circular(10),
                            topLeft: (index.isEven)
                                ? const Radius.circular(10)
                                : const Radius.circular(2),
                            bottomLeft: const Radius.circular(10),
                            bottomRight: const Radius.circular(10),
                          ),
                        ),
                        child: Text(
                          'Hallo, pesanan sesuai aplikasi ya',
                          style: TextStyle(
                            color: (index.isEven)
                                ? Colors.white
                                : Colors.grey[800],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 80, right: 15),
              child: Material(
                color: Colors.grey[100],
                elevation: 1.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(20),
                  child: Ink(
                    width: 30,
                    height: 30,
                    child: Center(
                      child: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Ink(
        height: 60,
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: kLightColor50,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(
                  cursorColor: Colors.grey[600],
                  cursorWidth: 1,
                  textInputAction: TextInputAction.send,
                  decoration: const InputDecoration(
                    hintText: 'Ketik sesuatu..',
                    contentPadding: EdgeInsets.only(
                      left: 20,
                      right: 20,
                      bottom: 10,
                    ),
                    border: InputBorder.none,
                    errorBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                  onSubmitted: null,
                ),
              ),
            ),
            const SizedBox(width: 10),
            InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(20),
              child: Ink(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Get.theme.primaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Icon(
                    Icons.send_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

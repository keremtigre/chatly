import 'package:auto_size_text/auto_size_text.dart';
import 'package:chatly/Product/extansions/button_style_extansions.dart';
import 'package:chatly/Product/extansions/container_extansions.dart';
import 'package:chatly/Product/extansions/context_extensions.dart';
import 'package:chatly/Product/extansions/text_form_field_extensions.dart';
import 'package:flutter/material.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({super.key});

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leadingWidth: context.width / 30,
          titleSpacing: 0.0,
          centerTitle: false,
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
          ],
          title: Row(
            children: [
              ClipOval(
                  child: Image.network(
                "https://img.freepik.com/free-photo/young-bearded-man-with-striped-shirt_273609-5677.jpg?w=2000&t=st=1677951687~exp=1677952287~hmac=491ed943f7e0e9032fde6666d377211514cec5884c62d3aedc25e8f1e51fdd28",
                fit: BoxFit.cover,
                width: 50.0,
                height: 50.0,
              )),
              SizedBox(
                width: context.width / 100,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AutoSizeText("Kerem Bey"),
                  isVisible
                      ? AutoSizeText(
                          "çevrimiçi",
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(fontSize: 14, color: Colors.white),
                        )
                      : const SizedBox()
                ],
              )
            ],
          ),
        ),
        body: Column(
          children: [
            Flexible(
              child: ListView.builder(
                itemCount: messageList.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      index % 2 == 0
                          ? const SizedBox(width: 10)
                          : const Spacer(),
                      Expanded(
                          child: Container().messageBoxStyle(
                        context,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(
                              messageList[index],
                              textAlign: TextAlign.start,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: AutoSizeText(
                                    "12:04",
                                    textAlign: TextAlign.end,
                                    style:
                                        Theme.of(context).textTheme.labelSmall,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  Icons.done_all,
                                  color: Theme.of(context).primaryColor,
                                )
                              ],
                            ),
                          ],
                        ),
                      )),
                      index % 2 == 1
                          ? const SizedBox(width: 10)
                          : const Spacer(),
                    ],
                  );
                },
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  vertical: context.height / 40,
                  horizontal: context.width / 60),
              width: context.width,
              height: context.height / 10,
              child: Row(
                children: [
                  Flexible(
                      flex: 4,
                      child: TextFormField(
                        decoration: const InputDecoration().sendMessageStyle(),
                      )),
                  Flexible(
                      child: ElevatedButton(
                          style: const ButtonStyle()
                              .sendMessageButtonStyle(context),
                          onPressed: () {},
                          child: const Icon(Icons.send)))
                ],
              ),
            )
          ],
        ));
  }

  List<String> messageList = [
    "günaydınn",
    "günaydınn",
    "akşam 8'de yemek "
    /*  "Selam Kerem!",
    "Selam Buse!",
    "Nasılsın?",
    "iyiyim, sen nasılsın?",
    "bende iyiyim",
    "seni seviyorum demek için mesaj attım, ayrıdca çoook ama çook",
    "bende seni seviyorum canımm <333" */
  ];
}

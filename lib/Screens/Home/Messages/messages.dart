import 'package:auto_size_text/auto_size_text.dart';
import 'package:chatly/Product/extansions/context_extensions.dart';
import 'package:flutter/material.dart';

class MessagesPage extends StatefulWidget {
  MessagesPage({super.key});

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
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))],
          title: Row(
            children: [
              const CircleAvatar(
                child: Text("K"),
              ),
              SizedBox(
                width: context.width / 100,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText("Kerem Bey"),
                  isVisible
                      ? AutoSizeText(
                          "çevrimiçi",
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(fontSize: 14, color: Colors.white),
                        )
                      : SizedBox()
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
                      index % 2 == 0 ? SizedBox(width: 10) : Spacer(),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.4),
                              borderRadius: BorderRadius.circular(9)),
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(top: 20),
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
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall,
                                    ),
                                  ),
                                  SizedBox(
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
                        ),
                      ),
                      index % 2 == 1 ? SizedBox(width: 10) : Spacer(),
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
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            filled: true,
                            hintStyle: TextStyle(color: Colors.grey[800]),
                            hintText: "Type in your message",
                            fillColor: Colors.white70),
                      )),
                  Flexible(
                      child: ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(CircleBorder()),
                            padding:
                                MaterialStateProperty.all(EdgeInsets.all(15)),
                            backgroundColor: MaterialStateProperty.all(
                                Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.8)), // <-- Button color
                            overlayColor:
                                MaterialStateProperty.resolveWith<Color?>(
                                    (states) {
                              if (states.contains(MaterialState.pressed))
                                return Colors.red; // <-- Splash color
                            }),
                          ),
                          onPressed: () {},
                          child: Icon(Icons.send)))
                ],
              ),
            )
          ],
        ));
  }

  List<String> messageList = [
    "Selam Kerem!",
    "Selam İlayda!",
    "Nasılsın?",
    "iyiyim, sen nasılsın?",
    "bende iyiyim",
    "seni seviyorum demek için mesaj attım, ayrıdca çoook ama çook",
    "bende seni seviyorum canımm <333"
  ];
}

import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:chatly/Product/extansions/context_extensions.dart';
import 'package:chatly/Product/routes/app_router.dart';
import 'package:flutter/material.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.message),
        onPressed: () {},
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              onTap: () {
                context.router.push(MessagesRoute());
              },
              title: AutoSizeText("$index Bey"),
              subtitle: Row(
                children: [
                  index % 2 == 0
                      ? const Icon(
                          Icons.done_all,
                          color: Colors.blue,
                        )
                      : const SizedBox(),
                  index % 2 == 0
                      ? SizedBox(width: context.width / 100)
                      : const SizedBox(),
                  const AutoSizeText("günaydınn aşkım nasılsın"),
                ],
              ),
              leading: CircleAvatar(
                child: Text(index.toString()),
              ),
              trailing: AutoSizeText("12.04",
                  style: Theme.of(context).textTheme.subtitle2!.copyWith(
                        color: Colors.black54,
                      )),
            ),
          );
        },
      ),
    );
  }
}

part of messages.dart;

class _MessagesPageAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const _MessagesPageAppBar({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final MessagesPage widget;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: context.width / 30,
      titleSpacing: 0.0,
      centerTitle: false,
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
      ],
      title: Row(
        children: [
          widget.userPhotoUrl != ""
              ? GestureDetector(
                  onTap: () {
                    showDialog(
                      barrierLabel: "Image",
                      barrierDismissible: true,
                      context: context,
                      builder: (context) {
                        return Material(
                          color: Colors.transparent,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.network("${widget.userPhotoUrl}"),
                              ),
                              SizedBox(
                                width: context.width / 3,
                                child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Icon(Icons.arrow_back),
                                        SizedBox(width: 15),
                                        Text("Back"),
                                      ],
                                    )),
                              )
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: ClipOval(
                      child: Image.network(
                    "${widget.userPhotoUrl}",
                    fit: BoxFit.cover,
                    width: 50.0,
                    height: 50.0,
                  )),
                )
              : CircleAvatar(
                  backgroundColor: const AppColors().platinium,
                  child: AutoSizeText(
                      widget.userName?.substring(0, 1).toUpperCase() ?? ""),
                ),
          SizedBox(
            width: context.width / 100,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<MessagesCubit, MessagesState>(
                builder: (context, state) {
                  return AutoSizeText(
                    widget.userName ?? "",
                    maxLines: 1,
                  );
                },
              ),
              AutoSizeText(
                "çevrimiçi",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontSize: 14, color: Colors.white),
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

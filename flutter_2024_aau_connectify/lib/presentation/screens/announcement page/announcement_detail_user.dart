import 'package:flutter/material.dart';
import 'package:flutter_2024_aau_connectify/bloc/announcement_bloc/announcement_bloc.dart';
import 'package:flutter_2024_aau_connectify/bloc/comment_bloc/comment_bloc.dart';
import 'package:flutter_2024_aau_connectify/presentation/navigation/route.dart';
import 'package:flutter_2024_aau_connectify/presentation/style/paddings.dart';
import 'package:flutter_2024_aau_connectify/presentation/style/typography.dart';
import 'package:flutter_2024_aau_connectify/presentation/widgets/announcement_description_card.dart';
import 'package:flutter_2024_aau_connectify/presentation/widgets/announcement_detail_image_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AnnouncementDetailUser extends StatelessWidget {
  final String id;
  const AnnouncementDetailUser({super.key, required this.id});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("post detail"),
        leading: IconButton(
            onPressed: () {
              context.go(homeRoute);
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: ListView(
        children: [
          BlocBuilder<AnnouncementBloc, AnnouncementState>(
            builder: (context, state) {
              if (state is SingleAnnouncementLoaded) {
                final data = state.announcement;
                return Expanded(
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: CustomPaddings.medium,
                          bottom: CustomPaddings.small,
                          left: CustomPaddings.small),
                      child: Text(
                        data.title,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(fontSize: CustomFontSize.h3),
                      ),
                    ),
                    AnnouncementDetailImageCard(image: data.image),
                    AnnouncementDescriptionCard(
                      announcement: data,
                    ),
                  ]),
                );
              }

              if (state is AnnouncementOperationFailure) {
                return Center(child: Text((state).error));
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          const Card(
            child: Padding(
              padding: EdgeInsets.all(CustomPaddings.medium),
              child: TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  disabledBorder: UnderlineInputBorder(),
                  focusedBorder: UnderlineInputBorder(),
                  enabledBorder: UnderlineInputBorder(),
                  hintText: 'Add a comment...',
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(CustomPaddings.extraLarge),
            child: ElevatedButton(
              style: ButtonStyle(
                alignment: Alignment.center,
                textStyle: MaterialStatePropertyAll(
                    Theme.of(context).textTheme.titleLarge),
                padding: const MaterialStatePropertyAll(
                  EdgeInsets.symmetric(
                      horizontal: CustomPaddings.medium,
                      vertical: CustomPaddings.large),
                ),
              ),
              onPressed: () {
                BlocProvider.of<CommentBloc>(context).add(
                  CreateComment('This is a comment from the user. on the land of bad', id),
                );
              },
              child: const Text('Post Comment'),
            ),
          ),
          const Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://img-s-msn-com.akamaized.net/tenant/amp/entityid/BB1msyCD.img'),
                ),
                title: Text('John Doe'),
                subtitle: Text('This is a comment from the user.'),
              ),
              Divider(),
            ],
          ),
          Column(
            children: [
              const ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://img-s-msn-com.akamaized.net/tenant/amp/entityid/BB1msyCD.img'),
                ),
                title: Text('John Doe'),
                subtitle: Text('This is a comment from the user.'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //edit button
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Edit'),
                  ),
                  //delete button
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                          Theme.of(context).colorScheme.error),
                    ),
                    onPressed: () {},
                    child: const Text('Delete'),
                  ),
                ],
              ),
              const Divider(),
            ],
          ),
          const Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://img-s-msn-com.akamaized.net/tenant/amp/entityid/BB1msyCD.img'),
                ),
                title: Text('John Doe'),
                subtitle: Text('This is a comment from the user.'),
              ),
              Divider(),
            ],
          ),
        ],
      ),
    );
  }
}

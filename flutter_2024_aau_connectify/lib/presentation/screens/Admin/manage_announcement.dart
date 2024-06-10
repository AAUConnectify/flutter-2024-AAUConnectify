import 'package:flutter/material.dart';
import 'package:flutter_2024_aau_connectify/bloc/announcement_bloc/announcement_bloc.dart';
import 'package:flutter_2024_aau_connectify/models/announcement_mode.dart';
import 'package:flutter_2024_aau_connectify/presentation/navigation/route.dart';
import 'package:flutter_2024_aau_connectify/presentation/style/colors.dart';
import 'package:flutter_2024_aau_connectify/presentation/style/paddings.dart';
import 'package:flutter_2024_aau_connectify/presentation/widgets/annoucement_admin.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ManageAnnouncement extends StatelessWidget {
  const ManageAnnouncement({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AnnouncementBloc>(context)
        .add(const FetchAnnouncements(1, 1000));
    return BlocListener<AnnouncementBloc, AnnouncementState>(
      listener: (context, state) {
        if (state is AnnouncementOperationSuccess) {
          // pop up
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Delete Succus'),
            backgroundColor: CustomColors.primaryColor,
          ));

          BlocProvider.of<AnnouncementBloc>(context)
              .add(const FetchAnnouncements(1, 1000));
        }
        if (state is AnnouncementOperationFailure) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.error),
            backgroundColor: CustomColors.errorColor,
          ));
        }
      },
      child: Stack(children: [
        Column(
          children: [
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                  horizontal: CustomPaddings.large,
                  vertical: CustomPaddings.extraLarge),
              child: Text(
                "Manage Announcement",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            Expanded(
              child: BlocBuilder<AnnouncementBloc, AnnouncementState>(
                builder: (context, state) {
                  if (state is AnnouncementLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is AnnouncementsLoaded) {
                    return ListView.builder(
                        itemCount: state.announcements.length,
                        itemBuilder: (context, index) {
                          final Announcement data = state.announcements[index];
                          return AnnouncementManagementTile(
                            imageUrl: data.image,
                            name: data.title,
                            onDelete: () {
                              BlocProvider.of<AnnouncementBloc>(context)
                                  .add(DeleteAnnouncement(data.id));
                            },
                            onEdit: () {
                              context.go(updateAnnouncementRoute, extra: {
                                'id': data.id,
                                'title': data.title,
                                'content': data.content,
                                'summery': data.summary,
                                'date': data.date,
                                'image': data.image,
                                'tag': data.tag,
                              });
                            },
                            onOpen: () {
                              context.go(announcementDetailUserRoute,
                                  extra: {'id': data.id});
                            },
                          );
                        });
                  }
                  if (state is NoTokenFound) {
                    context.go(landingpageRoute);
                  }
                  return Center(
                    child: ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<AnnouncementBloc>(context)
                              .add(const FetchAnnouncements(1, 1000));
                        },
                        child: const Text('Refresh')),
                  );
                },
              ),
            ),
          ],
        ),
        Positioned(
            right: 20,
            bottom: 20,
            child: FloatingActionButton(
              onPressed: () {
                context.go(createAnnouncementRoute);
              },
              child: const Icon(Icons.add),
            ))
      ]),
    );
  }
}

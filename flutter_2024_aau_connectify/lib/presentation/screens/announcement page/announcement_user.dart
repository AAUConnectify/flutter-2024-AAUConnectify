import 'package:flutter/material.dart';
import 'package:flutter_2024_aau_connectify/application/announcement/announcement_bloc.dart';
import 'package:flutter_2024_aau_connectify/application/generalcubit/general_cubit.dart';
import 'package:flutter_2024_aau_connectify/presentation/navigation/route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../widgets/announcement_card.dart';
import '../../widgets/announcement_catagory.dart';

class AnnouncementUserPage extends StatelessWidget {
  const AnnouncementUserPage({super.key});
   static const List<String> announcementCatagory = [
  "All",
  "Academic",
  "Research",
  "Events",
  "Notices",
  "Internship",
  "Career",
  "Other"
];

  @override
  Widget build(BuildContext context) {
    return BlocListener<AnnouncementBloc, AnnouncementState>(
      listener: (context, state) {
        if (state is NoTokenFound) {
          context.go(landingpageRoute);
        }
      },
      child: Column(
        children: [
          const AnnouncementCatagory(),
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
              child: BlocBuilder<AnnouncementBloc, AnnouncementState>(
                builder: (context, state) {
                  if (state is AnnouncementsLoaded) {
                    int currentIndex = context.watch<GeneralCubit>().category;
                    final allData = state.announcements;

                    List data = [];
                    for(var i in allData){
                      
                      if(i.tag == announcementCatagory[currentIndex] || announcementCatagory[currentIndex] == 'All' ){
                        data.add(i);
                      }
                    }

                    return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return AnnouncementCard(
                              id: data[index].id,
                              title: data[index].title,
                              images: data[index].image,
                              date: DateTime.parse(data[index].date),
                              summary: data[index].summary);
                        });
                  } else if (state is AnnouncementOperationFailure) {
                    return Center(child: Text((state).error));
                  } else if (state is AnnouncementLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return const Center(
                      child: Text('No Announcement at the current'));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

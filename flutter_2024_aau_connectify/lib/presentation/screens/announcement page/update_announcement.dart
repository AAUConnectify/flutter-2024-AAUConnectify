import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_2024_aau_connectify/bloc/announcement_bloc/announcement_bloc.dart';
import 'package:flutter_2024_aau_connectify/presentation/navigation/route.dart';
import 'package:flutter_2024_aau_connectify/presentation/style/paddings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// ignore: must_be_immutable
class UpdateAnnouncements extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController summeryController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final TextEditingController imageController = TextEditingController();
  final TextEditingController tagController = TextEditingController();
  // if these fields are given we gonna use them if nor given the gonna be null

  final String? title;
  final String? date;
  final String? summery;
  final String? content;
  final String? image;
  final String? tag;
  
  final String id;

  UpdateAnnouncements(
      {super.key,
      this.title,
      this.date,
      this.summery,
      this.content,
      this.image,
      this.tag,  required this.id}) {
    titleController.text = title ?? '';
    dateController.text = date ?? '';
    summeryController.text = summery ?? '';
    contentController.text = content ?? '';
    imageController.text = image ?? '';
    tagController.text = tag ?? '';

  }
  List<String> tags = [
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
    return SafeArea(
        child: BlocListener<AnnouncementBloc, AnnouncementState>(
      listener: (context, state)async {
        if (state is AnnouncementOperationSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Announcement Created Successfully')));
          await Future.delayed(const Duration(seconds: 2));
          context.go(homeRoute);
        }
        if (state is AnnouncementOperationFailure) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text((state).error)));
        }
        if (state is NoTokenFound) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('No Token Found, Please Login')));
          Future.delayed(const Duration(seconds: 2));
          context.go(loginRoute);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Update Announcement'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              context.go(homeRoute);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: CustomPaddings.small),
                  child: TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                    ),
                    maxLines: null,
                  ),
                ),
                //date  picker
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: CustomPaddings.small),
                  child: TextField(
                    controller: dateController,
                    decoration: InputDecoration(
                        labelText: 'Date',
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(
                              right: CustomPaddings.small),
                          child: IconButton(
                              color: Theme.of(context).primaryColor,
                              onPressed: () async {
                                final DateTime? pickedDate =
                                    await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1000),
                                  lastDate: DateTime(3000),
                                );
                                if (pickedDate != null) {
                                  //only the date
                                  dateController.text =
                                      pickedDate.toString().substring(0, 10);
                                }
                              },
                              icon: Icon(Icons.calendar_today,
                                  color: Theme.of(context).primaryColor)),
                        ),
                        suffixStyle: TextStyle(
                          color: Theme.of(context).primaryColor,
                        )),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: CustomPaddings.small),
                  child: TextField(
                    controller: summeryController,
                    decoration: const InputDecoration(
                      labelText: 'Summery',
                    ),
                    maxLines: null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: CustomPaddings.small),
                  child: TextFormField(
                    controller: contentController,
                    decoration: const InputDecoration(
                      labelText: 'Content',
                    ),
                    maxLines: null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: CustomPaddings.small),
                  child: TextField(
                    controller: imageController,
                    decoration: const InputDecoration(
                      labelText: 'Image',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: CustomPaddings.small),
                  child: DropdownButtonFormField<String>(
                    value: tagController.text,
                    decoration: const InputDecoration(
                        labelText: 'Tag',
                        filled: true,
                        fillColor: Colors.white,
                        focusColor: Colors.white),
                    items: tags.map((ele) {
                      return DropdownMenuItem<String>(
                          value: ele, child: Text(ele));
                    }).toList(),
                    onChanged: (String? value) {
                      tagController.text = value!;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 12),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        textStyle: MaterialStatePropertyAll(
                            Theme.of(context).textTheme.titleLarge!),
                        padding: const MaterialStatePropertyAll(
                            EdgeInsets.symmetric(
                                horizontal: 25, vertical: 20))),
                    onPressed: () {
                      BlocProvider.of<AnnouncementBloc>(context).add(
                          UpdateAnnouncement(
                              title: titleController.text,
                              date: dateController.text,
                              summary: summeryController.text,
                              content: contentController.text,
                              image: imageController.text,
                              tag: tagController.text, 
                              id: id
                              ));
                    },
                    child: BlocBuilder<AnnouncementBloc, AnnouncementState>(
                      builder: (context, state) {
                        if (state is AnnouncementLoading) {
                          return const CircularProgressIndicator();
                        }
                        return const Text('Update Announcement');
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}

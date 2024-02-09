import 'package:campuscollaborate/constants/routing_constants.dart';
import 'package:campuscollaborate/constants/themes.dart';
import 'package:campuscollaborate/locator.dart';
import 'package:campuscollaborate/models/user_info.dart';
import 'package:campuscollaborate/services/reset_providers.dart';
import 'package:campuscollaborate/widgets/commonWidgets/common_text_field.dart';
import 'package:campuscollaborate/widgets/commonWidgets/project_container.dart';
import 'package:flutter/material.dart';

import '../models/project.dart';

class HomeScreen extends StatelessWidget {
  final UserInfo userInfo;
  final List<Project>? project;
  const HomeScreen({super.key, required this.userInfo, this.project});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchTextController = TextEditingController();
    return SafeArea(
        child: Scaffold(
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: FloatingActionButton(onPressed: (){
              ResetProviders.reset(context);
              navigationService.pushScreen(Routes.createProjectScreen);
            },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)
              ),
              child: const Icon(Icons.add, color: Colors.white,),
            ),
          ),
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(70),
            child: AppBar(
              backgroundColor: Themes.getColors(ColorsValues.DARK_GREY_COLOR),
              title: Padding(
              padding: const EdgeInsets.only(top: 10), child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  'Campus',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  'Collab',
                  style: TextStyle(
                      color: Themes.getColors(ColorsValues.ORANGE_COLOR),
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap:(){
                      navigationService.pushScreen(Routes.profileScreen, arguments: userInfo);
                    },
                    child: const CircleAvatar(radius: 45,
                      backgroundImage: AssetImage('assets/circular_user.png'),
                      foregroundImage: AssetImage('assets/circular_user.png'),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            const Text(
              'My Feed',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 20,
            ),
            CommonTextField(
              textEditingController: searchTextController,
              hintText: "Search Project",
              suffix: Image.asset('assets/funnel.png'),
            ),
            const SizedBox(
              height: 20,
            ),
            project == null || project!.isEmpty
                ? const Center(
                    child: Text('No Projects to Show!'),
                  )
                : Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: project!.length,
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: (){
                            navigationService.pushScreen(Routes.projectScreen, arguments:project![index]);
                          },
                          child: ProjectContainer(
                              project: project![index]),
                        )),
                  )
          ],
        ),
      ),
    ));
  }
}

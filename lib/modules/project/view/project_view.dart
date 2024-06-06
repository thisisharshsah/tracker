import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../project.dart';

class ProjectView extends StatelessWidget {
  const ProjectView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Projects', style: Theme.of(context).textTheme.labelLarge),
        backgroundColor: Theme.of(context).primaryColor,
        automaticallyImplyLeading: false,
      ),
      body: BlocBuilder<ProjectBloc, ProjectState>(
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<ProjectBloc>().add(const ProjectInitial());
            },
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: 0.8.sh,
              ),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 10.sp),
                itemCount: state.projects.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 10.sp),
                    child: Card(
                      elevation: 0,
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.1),
                      margin: EdgeInsets.zero,
                      child: Padding(
                        padding: EdgeInsets.all(10.sp),
                        child: ListTile(
                          onTap: () {
                            context.read<ProjectBloc>().add(
                                  ProjectSelected(
                                    state.projects[index],
                                  ),
                                );
                          },
                          contentPadding: EdgeInsets.zero,
                          leading: CircleAvatar(
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            // "#" icon
                            child: Icon(
                              Icons.tag,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          title: Text(
                            state.projects[index].name,
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          subtitle: Row(
                            children: [
                              // 30.comments
                              Text(
                                state.projects[index].commentCount.toString(),
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                              5.horizontalSpace,
                              Text(
                                'Comments',
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                            ],
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.more_vert),
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

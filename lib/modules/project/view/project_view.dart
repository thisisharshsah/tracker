import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../global/global.dart';
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
        actions: [
          CustomIconButton(
            onPressed: () => showCustomBottomSheet(
              child: Padding(
                padding: EdgeInsets.all(10.sp),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Create a new project',
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                    10.verticalSpace,
                    CustomTextFormField(
                      label: 'Project name',
                      icon: Icons.title,
                      hint: 'Enter project name',
                      onChanged: (value) => context
                          .read<ProjectBloc>()
                          .add(ProjectNameChanged(value!)),
                    ),
                    10.verticalSpace,
                    PrimaryButton(
                      label: 'Create',
                      onPressed: () => context
                          .read<ProjectBloc>()
                          .add(const ProjectCreated()),
                    ),
                    10.verticalSpace,
                  ],
                ),
              ),
            ),
            label: 'Add',
            icon: Icons.add_rounded,
          )
        ],
      ),
      body: BlocBuilder<ProjectBloc, ProjectState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CustomLoading());
          } else if (state.projects.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.tag,
                    size: 100.sp,
                    weight: 1,
                    color: Theme.of(context).hintColor,
                  ),
                  10.verticalSpace,
                  Text(
                    'Please create a project',
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: Theme.of(context).hintColor,
                        ),
                  ),
                ],
              ),
            );
          }
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
                          onTap: () => context
                              .read<ProjectBloc>()
                              .add(ProjectSelected(state.projects[index])),
                          contentPadding: EdgeInsets.zero,
                          leading: CircleAvatar(
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
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

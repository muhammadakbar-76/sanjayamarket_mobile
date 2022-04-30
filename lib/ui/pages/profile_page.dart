import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sanjaya/cubit/auth_cubit.dart';
import 'package:sanjaya/shared/theme.dart';
import 'package:sanjaya/ui/widgets/profile_page_content.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        width: double.infinity,
        color: Colors.white,
        margin: const EdgeInsets.only(bottom: 24),
        child: Center(
          child: BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              if (state is AuthSuccess) {
                return Column(
                  children: [
                    const SizedBox(height: 26),
                    DottedBorder(
                      borderType: BorderType.Circle,
                      color: cSecondaryColor,
                      dashPattern: const [16, 12],
                      child: Center(
                        child: Container(
                          height: 110,
                          width: 110,
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage(
                                    "$mainUrl${state.user.photoPath}"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      state.user.name,
                      style: tBlackText.copyWith(
                        fontWeight: medium,
                        fontSize: 18,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      state.user.email,
                      style: tGreyText.copyWith(
                        fontWeight: light,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 26),
                  ],
                );
              }
              return const SizedBox();
            },
          ),
        ),
      );
    }

    return ListView(
      children: [
        header(),
        const ProfilePageContent(),
      ],
    );
  }
}

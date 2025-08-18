import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth/auth_bloc.dart';
import '../bloc/home/home_bloc.dart';
import '../bloc/home/home_event.dart';
import '../bloc/home/home_state.dart';

class PageHome extends StatelessWidget {
  const PageHome({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.read<AuthBloc>().auth!; //If you are in then have the token
    return BlocProvider(
      create: (context) => HomeBloc(accessToken: auth.token)..add(HomeFetched()),
      child: Scaffold(
        body: BlocListener<HomeBloc, HomeState>(
          listener: (context, state) {},
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              return PageView.builder(
                scrollDirection: Axis.vertical,
                itemCount: state.listMovie.length,
                itemBuilder: (context, index) {
                  return Container(
                    color: Colors.black,
                    child: Center(
                      child: Image.network(
                        state.listMovie.elementAt(index).Images.first,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

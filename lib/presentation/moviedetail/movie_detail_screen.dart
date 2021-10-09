import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluvie/factory/repository_factory.dart';
import 'package:fluvie/model/base/request_state.dart';
import 'package:fluvie/presentation/moviedetail/bloc/detail_bloc.dart';

class MovieDetailScreen extends StatelessWidget {
  const MovieDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => DetailBloc(
            InitialState(),
            RepositoryFactory.getMovieRepository(),
          ),
        )
      ],
      child: Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.arrow_back),
          title: const Text('Movie Detail'),
        ),
        body: BlocBuilder<DetailBloc, RequestState>(
          builder: (context, state) => Center(
            child: Builder(
              builder: (_) {
                if (state is LoadingState) {
                  return const CircularProgressIndicator();
                } else if (state is ErrorState) {
                  return Text('Error : ${state.error.statusMessage}');
                } else if (state is SuccessState) {
                  return const Text('Success');
                }

                context.read<DetailBloc>().getDetail();

                return const SizedBox(width: 0);
              },
            ),
          ),
        ),
      ),
    );
  }
}

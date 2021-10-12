import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluvie/bloc/moviedetail/movie_detail_favorite_bloc.dart';
import 'package:fluvie/factory/repository_factory.dart';
import 'package:fluvie/model/base/request_state.dart';
import 'package:fluvie/model/view/movie.dart';
import 'package:fluvie/bloc/moviedetail/movie_detail_bloc.dart';
import 'package:fluvie/presentation/moviedetail/widget/list_item_genre.dart';
import 'package:fluvie/resource/assets/local_images_path.dart';
import 'package:fluvie/resource/styles/dimens.dart';
import 'package:fluvie/resource/styles/text_styles.dart';
import 'package:fluvie/widget/common/error_message_snackbar.dart';
import 'package:fluvie/widget/shimmer/shimmer_container.dart';
import 'package:fluvie/widget/shimmer/shimmer_text.dart';

class MovieDetailScreen extends StatelessWidget {
  const MovieDetailScreen({Key? key}) : super(key: key);

  PreferredSizeWidget _buildAppBar(RequestState state) {
    return AppBar(
      backgroundColor: Colors.white,
      titleTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 20.0,
        fontWeight: FontWeight.w600,
      ),
      leading: IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.arrow_back_rounded,
          color: Colors.black,
        ),
      ),
      title: Builder(
        builder: (_) {
          if (state is SuccessState<Movie>) {
            return Text(state.data.title ?? '');
          } else if (state is LoadingState) {
            return const Text('Getting detail ...');
          } else {
            return const Text('Detail');
          }
        },
      ),
    );
  }

  Widget _buildPosterAndFavorite(BuildContext context, RequestState state) {
    return AspectRatio(
      aspectRatio: 3 / 5,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            margin: const EdgeInsets.only(bottom: Dimens.spacingXLarge),
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(56.0),
              bottomRight: Radius.circular(56.0),
            )),
            child: Builder(
              builder: (context) {
                if (state is SuccessState<Movie>) {
                  return FadeInImage.assetNetwork(
                    image: state.data.fullImageUrl,
                    placeholder: LocalImagesPath.squarePlaceholder,
                    fit: BoxFit.cover,
                  );
                } else {
                  return Image.asset(
                    LocalImagesPath.squarePlaceholder,
                    fit: BoxFit.cover,
                  );
                }
              },
            ),
          ),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FloatingActionButton(
                  onPressed: () {},
                  backgroundColor: Colors.white,
                  elevation: Dimens.fabElevation,
                  child: const Icon(
                    Icons.share_rounded,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: Dimens.spacingMedium),
                SizedBox(
                  width: Dimens.fabLarge,
                  height: Dimens.fabLarge,
                  child: RawMaterialButton(
                    onPressed: () {},
                    fillColor: Colors.blue,
                    elevation: Dimens.fabElevation,
                    shape: const CircleBorder(),
                    child: const Icon(
                      Icons.play_arrow_rounded,
                      color: Colors.white,
                      size: Dimens.iconLarge,
                    ),
                  ),
                ),
                const SizedBox(width: Dimens.spacingMedium),
                BlocBuilder<MovieDetailFavoriteBloc, bool>(
                  builder: (context, isFavorite) {
                    return FloatingActionButton(
                      onPressed: context
                          .read<MovieDetailFavoriteBloc>()
                          .toggleFavorite,
                      backgroundColor: Colors.white,
                      elevation: Dimens.fabElevation,
                      child: Icon(
                        Icons.favorite,
                        color: isFavorite ? Colors.red[400] : Colors.grey[500],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitleAndSummary(RequestState state) {
    if (state is LoadingState) {
      return ShimmerContainer(
        child: Container(
          margin: const EdgeInsets.only(
            right: Dimens.spacingLarge,
            left: Dimens.spacingLarge,
            top: Dimens.spacingMedium,
            bottom: Dimens.spacingNormal,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              ShimmerText(height: Dimens.textXLarge),
              SizedBox(height: Dimens.spacingSmall),
              ShimmerText(
                width: 100,
                height: Dimens.textNormal,
              ),
            ],
          ),
        ),
      );
    } else if (state is SuccessState<Movie>) {
      return Container(
        margin: const EdgeInsets.only(
          right: Dimens.spacingLarge,
            left: Dimens.spacingLarge,
            top: Dimens.spacingMedium,
            bottom: Dimens.spacingNormal,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              state.data.title ?? '',
              style: TextStyles.header,
            ),
            const SizedBox(height: Dimens.spacingSmall),
            Text(
              state.data.overview ?? '',
              style: TextStyles.content,
            ),
          ],
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  Widget _buildGenres(RequestState state) {
    if (state is LoadingState) {
      return SliverToBoxAdapter(
        child: Container(
          height: Dimens.textXLarge,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: Dimens.spacingLarge),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return const ListItemGenre(isLoading: true);
            },
            itemCount: 3,
          ),
        ),
      );
    } else if (state is SuccessState<Movie>) {
      return SliverToBoxAdapter(
        child: Container(
          height: Dimens.textXLarge,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: Dimens.spacingLarge),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return ListItemGenre(
                isLoading: false,
                genre: state.data.genres?[index],
              );
            },
            itemCount: state.data.genres?.length ?? 0,
          ),
        ),
      );
    } else {
      return const SliverToBoxAdapter(child: SizedBox());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MovieDetailBloc(
            InitialState(),
            RepositoryFactory.getMovieRepository(),
          ),
        ),
        BlocProvider(
          create: (context) => MovieDetailFavoriteBloc(
            false,
            RepositoryFactory.getMovieRepository(),
          ),
        ),
      ],
      child: BlocConsumer<MovieDetailBloc, RequestState>(
        listener: (context, state) {
          if (state is ErrorState) {
            ErrorMessageSnackbar.show(context, state.message);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: _buildAppBar(state),
            body: RefreshIndicator(
              onRefresh: context.read<MovieDetailBloc>().getDetail,
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _buildPosterAndFavorite(context, state),
                        _buildTitleAndSummary(state),
                      ],
                    ),
                  ),
                  _buildGenres(state),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

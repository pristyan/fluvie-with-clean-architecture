import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluvie/bloc/moviedetail/movie_detail_favorite_bloc.dart';
import 'package:fluvie/factory/repository_factory.dart';
import 'package:fluvie/model/base/request_state.dart';
import 'package:fluvie/model/view/movie.dart';
import 'package:fluvie/bloc/moviedetail/movie_detail_bloc.dart';
import 'package:fluvie/presentation/moviedetail/widget/list_item_company.dart';
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

  Widget _buildPosterBasedOnState(RequestState state) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      margin: const EdgeInsets.only(bottom: Dimens.spacingXLarge),
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(56.0),
          bottomRight: Radius.circular(56.0),
        ),
      ),
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
    );
  }

  Widget _buildButtonsOnPoster(Movie movie) {
    return Positioned(
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
                onPressed: () => context
                    .read<MovieDetailFavoriteBloc>()
                    .toggleFavorite(movie),
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
    );
  }

  Widget _buildHeader(RequestState state) {
    return SliverToBoxAdapter(
      child: AspectRatio(
        aspectRatio: 3 / 5,
        child: Builder(
          builder: (context) {
            if (state is SuccessState<Movie>) {
              return Stack(
                children: [
                  _buildPosterBasedOnState(state),
                  _buildButtonsOnPoster(state.data),
                ],
              );
            } else {
              return _buildPosterBasedOnState(state);
            }
          },
        ),
      ),
    );
  }

  Widget _buildTitleAndTagline(RequestState state) {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: Dimens.spacingLarge,
          vertical: Dimens.spacingMedium,
        ),
        child: Builder(builder: (context) {
          if (state is LoadingState) {
            return ShimmerContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  ShimmerText(
                    height: Dimens.textXLarge,
                    width: double.infinity,
                  ),
                  SizedBox(height: Dimens.spacingSmall),
                  ShimmerText(
                    height: Dimens.textSmall,
                    width: 150,
                  ),
                ],
              ),
            );
          } else if (state is SuccessState<Movie>) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  state.data.title ?? '',
                  style: TextStyles.header,
                ),
                Text(
                  state.data.tagline ?? '',
                  style: TextStyles.caption,
                ),
              ],
            );
          } else {
            return const SizedBox();
          }
        }),
      ),
    );
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

  Widget _buildDescription(RequestState state) {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: Dimens.spacingMedium,
          horizontal: Dimens.spacingLarge,
        ),
        child: Builder(builder: (context) {
          if (state is LoadingState) {
            return ShimmerContainer(
              child: Column(
                children: const [
                  ShimmerText(
                    width: double.infinity,
                    height: Dimens.textNormal,
                  ),
                  SizedBox(height: Dimens.spacingSmall),
                  ShimmerText(
                    width: double.infinity,
                    height: Dimens.textNormal,
                  ),
                  SizedBox(height: Dimens.spacingSmall),
                  ShimmerText(
                    width: 150,
                    height: Dimens.textNormal,
                  ),
                ],
              ),
            );
          } else if (state is SuccessState<Movie>) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Overview',
                  style: TextStyles.sectionHeader,
                ),
                const SizedBox(height: Dimens.spacingSmall),
                Text(
                  state.data.overview ?? '',
                  style: TextStyles.content,
                ),
              ],
            );
          } else {
            return const SizedBox();
          }
        }),
      ),
    );
  }

  Widget _buildCompanySectionHeader() {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.only(
          left: Dimens.spacingLarge,
        ),
        child: const Text(
          'Production Companies',
          style: TextStyles.sectionHeader,
        ),
      ),
    );
  }

  Widget _buildCompanies(RequestState state) {
    if (state is SuccessState<Movie>) {
      return SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          return ListItemCompany(
            isLoading: false,
            company: state.data.productionCompanies?[index],
          );
        }, childCount: state.data.productionCompanies?.length ?? 0),
      );
    } else {
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => const ListItemCompany(isLoading: true),
          childCount: 3,
        ),
      );
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

          if (state is SuccessState<Movie>) {
            context.read<MovieDetailFavoriteBloc>().checkFavorite(state.data);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: _buildAppBar(state),
            body: RefreshIndicator(
              onRefresh: context.read<MovieDetailBloc>().getDetail,
              child: CustomScrollView(
                slivers: [
                  _buildHeader(state),
                  _buildTitleAndTagline(state),
                  _buildGenres(state),
                  _buildDescription(state),
                  _buildCompanySectionHeader(),
                  _buildCompanies(state),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:fluvie/model/view/genre.dart';
import 'package:fluvie/resource/styles/dimens.dart';
import 'package:fluvie/resource/styles/text_styles.dart';
import 'package:fluvie/widget/shimmer/shimmer_container.dart';
import 'package:fluvie/widget/shimmer/shimmer_text.dart';

class ListItemGenre extends StatelessWidget {
  final Genre? genre;
  final bool isLoading;

  const ListItemGenre({
    this.genre,
    required this.isLoading,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: Dimens.spacingNormal),
      child: Builder(
        builder: (context) {
          if (isLoading) {
            return const ShimmerContainer(
              child: ShimmerText(
                width: 80,
                height: Dimens.textNormal,
              ),
            );
          } else {
            return Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: const BorderRadiusDirectional.all(
                  Radius.circular(Dimens.spacingNormal),
                ),
              ),
              padding: const EdgeInsets.symmetric(
                vertical: Dimens.spacingSmall,
                horizontal: Dimens.spacingNormal,
              ),
              child: Text(
                genre?.name ?? '',
                style: TextStyles.content,
              ),
            );
          }
        },
      ),
    );
  }
}

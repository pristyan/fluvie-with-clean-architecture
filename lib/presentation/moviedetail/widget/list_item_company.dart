import 'package:flutter/material.dart';
import 'package:fluvie/model/view/production_company.dart';
import 'package:fluvie/resource/assets/local_images_path.dart';
import 'package:fluvie/resource/styles/dimens.dart';
import 'package:fluvie/resource/styles/text_styles.dart';
import 'package:fluvie/widget/shimmer/shimmer_avatar.dart';
import 'package:fluvie/widget/shimmer/shimmer_container.dart';
import 'package:fluvie/widget/shimmer/shimmer_text.dart';

class ListItemCompany extends StatelessWidget {
  final ProductionCompany? company;
  final bool isLoading;

  const ListItemCompany({
    this.company,
    required this.isLoading,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: Dimens.spacingSmall,
        horizontal: Dimens.spacingLarge,
      ),
      child: Builder(builder: (context) {
        if (isLoading) {
          return ShimmerContainer(
            child: Row(
              children: [
                const ShimmerAvatar(size: Dimens.iconLarge),
                const SizedBox(width: Dimens.spacingMedium),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    ShimmerText(
                      height: Dimens.textNormal,
                      width: 150,
                    ),
                    SizedBox(height: Dimens.spacingSmall),
                    ShimmerText(
                      height: Dimens.textSmall,
                      width: 100,
                    ),
                  ],
                )
              ],
            ),
          );
        } else {
          return Row(
            children: [
              Container(
                width: Dimens.iconLarge,
                height: Dimens.iconLarge,
                decoration: const BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadiusDirectional.all(Radius.circular(Dimens.spacingNormal)),
                ),
                clipBehavior: Clip.antiAlias,
                child: Builder(builder: (context) {
                  if (company?.fullLogoPath == null) {
                    return Image.asset(LocalImagesPath.squarePlaceholder);
                  } else {
                    return FadeInImage.assetNetwork(
                      placeholder: LocalImagesPath.squarePlaceholder,
                      image: company?.fullLogoPath ?? '',
                    );
                  }
                }),
              ),
              const SizedBox(width: Dimens.spacingMedium),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    company?.name ?? '',
                    style: TextStyles.contentTitle,
                  ),
                  const SizedBox(height: Dimens.spacingSmall),
                  Text(
                    company?.originCountry ?? '',
                    style: TextStyles.caption,
                  ),
                ],
              )
            ],
          );
        }
      }),
    );
  }
}

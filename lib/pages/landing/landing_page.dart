import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:focus_detector_v2/focus_detector_v2.dart';

import '../../base/base_page.dart';
import '../../constants/app_color.dart';
import '../../constants/app_size.dart';
import '../../constants/app_text_style.dart';
import '../../controllers/connectivity_controller.dart';
import '../../utils/asset_util.dart';
import '../../utils/get_util.dart';
import '../../widgets/base/base_avatar.dart';
import '../../widgets/base/base_dialog.dart';
import '../../widgets/base/base_grid_view.dart';
import '../../widgets/base/base_shimmer.dart';
import '../backpack/backpack_page.dart';
import '../encounter/encounter_page.dart';
import '../favourite/favourite_page.dart';
import '../pokedex/pokedex_page.dart';
import '../search/search_page.dart';
import 'components/item_menu.dart';
import 'components/item_statistic.dart';
import 'landing_view_model.dart';

class LandingPage extends BasePage {
  const LandingPage({super.key});

  @override
  State<StatefulWidget> createState() => _LandingPageState();
}

class _LandingPageState extends BaseState<LandingPage> with BasicPage {
  final LandingViewModel _landingViewModel = GetUtil.put(LandingViewModel());
  final ConnectivityController _connectivityController = GetUtil.find<ConnectivityController>()!;

  @override
  Widget body() {
    return SafeArea(
      child: FocusDetector(
        onFocusGained: () {
          _landingViewModel.updateCount();
        },
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(AppSize.standardSize),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildNoInternetConnectionBanner(),
                _buildProfilePanel(),
                _buildStatisticPanel(),
                _buildMenuPanel(),
                _buildEncounterNewPokemon(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildProfilePanel() => Container(
        margin: EdgeInsets.only(bottom: AppSize.getSize(32)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'greeting'.translate(),
                  style: AppTextStyle.baseTextStyle(
                    fontWeightType: FontWeightType.medium,
                    fontSize: AppSize.getTextSize(18),
                  ),
                ),
                Text(
                  'Ash',
                  style: AppTextStyle.baseTextStyle(
                    fontWeightType: FontWeightType.bold,
                    fontSize: AppSize.getTextSize(20),
                  ),
                ),
              ],
            ),
            _buildAvatar()
          ],
        ),
      );

  _buildAvatar() => BaseAvatar(
        url: 'https://static.wikia.nocookie.net/ideas/images/9/9f/Ash_ketchum_render_by_tzblacktd-da9k0wb.png/revision/latest?cb=20180427162023',
        size: AppSize.getSize(100),
      );

  _buildMenuPanel() => Container(
        margin: EdgeInsets.only(bottom: AppSize.getSize(32)),
        child: BaseGridView(
          shrinkWrap: true,
          builder: (BuildContext context, int index) {
            return ItemMenu(menu: menuList[index]);
          },
          itemCount: menuList.length,
          crossAxisCount: 4,
        ),
      );

  _buildStatisticPanel() => Container(
        margin: EdgeInsets.only(bottom: AppSize.getSize(32)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'pokemon'.translate(),
              style: AppTextStyle.baseTextStyle(fontWeightType: FontWeightType.bold, fontSize: AppSize.getTextSize(18)),
            ),
            SizedBox(height: AppSize.getSize(8)),
            Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSize.getSize(32),
                  vertical: AppSize.getSize(16),
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(AppSize.getSize(12)),
                ),
                child: GetUtil.getX<LandingViewModel>(builder: (vm) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ItemStatistic(
                        count: vm.ownedCount.value,
                        label: 'owned'.translate(),
                      ),
                      ItemStatistic(
                        count: vm.releasedCount.value,
                        label: 'released'.translate(),
                      ),
                      ItemStatistic(
                        count: vm.fleeCount.value,
                        label: 'flee'.translate(),
                      ),
                    ],
                  );
                })),
          ],
        ),
      );

  _buildEncounterNewPokemon() {
    return InkWell(
      onTap: () {
        if (_connectivityController.isOnline.value) {
          GetUtil.navigateTo(const EncounterPage());
        } else {
          BaseDialog.show(message: 'required_internet_connection'.translate());
        }
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(AppSize.getSize(12)),
              child: SizedBox(
                width: AppSize.getScreenWidth(),
                height: AppSize.getScreenHeight(percent: 20),
                child: CachedNetworkImage(
                  placeholder: (context, url) => BaseShimmer.rectangular(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  fit: BoxFit.fitWidth,
                  imageUrl: 'https://lh3.googleusercontent.com/8Tiud9g_ZTxKuFq8OxCr2fJLOwMzA1ajIKeFiu8Ub11X9AImQ58WzVxyVd6KSNpG79ceaHuFT66aihceJFNIYrerNHtpMomB-UibKIdJcJx1=rw-e365-w3600',
                ),
              )),
          Container(
            padding: EdgeInsets.all(AppSize.getSize(8)),
            decoration: BoxDecoration(
              color: AppColor.white.withOpacity(0.7),
              borderRadius: BorderRadius.circular(AppSize.getSize(24)),
            ),
            child: Text(
              'encounter_wild_pokemon'.translate(),
              style: AppTextStyle.baseTextStyle(
                fontWeightType: FontWeightType.bold,
                fontSize: AppSize.getTextSize(16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildNoInternetConnectionBanner() => GetUtil.getObx(
        () => Visibility(
          visible: !_connectivityController.isOnline.value,
          child: Container(
            margin: EdgeInsets.only(bottom: AppSize.getSize(8)),
            alignment: Alignment.center,
            width: AppSize.getScreenWidth(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Icon(Icons.wifi_off),
                SizedBox(width: AppSize.getSize(16)),
                Text(
                  'no_internet_connection'.translate(),
                  style: AppTextStyle.getTextStyle(),
                ),
              ],
            ),
          ),
        ),
      );

  final menuList = [
    {
      'icon': AssetUtil.icSearch(color: AppColor.primaryColor),
      'label': 'search'.translate(),
      'tap': () {
        GetUtil.navigateTo(const SearchPage());
      },
    },
    {
      'icon': AssetUtil.icBook(color: AppColor.primaryColor),
      'label': 'pokedex'.translate(),
      'tap': () {
        GetUtil.navigateTo(const PokedexPage());
      },
    },
    {
      'icon': AssetUtil.icBackpack(color: AppColor.primaryColor),
      'label': 'backpack'.translate(),
      'tap': () async {
        GetUtil.navigateTo(const BackpackPage());
      },
    },
    {
      'icon': AssetUtil.icFavourite(color: AppColor.primaryColor),
      'label': 'favourite'.translate(),
      'tap': () {
        GetUtil.navigateTo(const FavouritePage());
      },
    },
  ];
}

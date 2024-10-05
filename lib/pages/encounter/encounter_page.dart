import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../base/base_page.dart';
import '../../base/base_view_model.dart';
import '../../constants/app_color.dart';
import '../../constants/app_size.dart';
import '../../constants/app_text_style.dart';
import '../../models/pokemon_detail.dart';
import '../../utils/asset_util.dart';
import '../../utils/get_util.dart';
import '../../utils/string_util.dart';
import '../../widgets/base/base_animate.dart';
import '../../widgets/base/base_app_bar.dart';
import '../../widgets/base/base_dialog.dart';
import 'components/item_action_button.dart';
import 'encounter_view_model.dart';

class EncounterPage extends BasePage {
  const EncounterPage({super.key});

  @override
  State<StatefulWidget> createState() => _EncounterPageState();
}

class _EncounterPageState extends BaseState<EncounterPage> with BasicPage {
  final EncounterViewModel _encounterViewModel = GetUtil.put(EncounterViewModel());

  @override
  PreferredSizeWidget? appBar() {
    return BaseAppBar();
  }

  @override
  Widget body() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(AppSize.standardSize),
          child: GetUtil.getX<EncounterViewModel>(builder: (vm) {
            ConnectionStateType connectionStateType = vm.connectionState;
            PokemonDetail wildPokemon = vm.wildPokemon.value;

            if (connectionStateType == ConnectionStateType.loading) {
              return Container(
                margin: EdgeInsets.only(top: AppSize.getScreenHeight(percent: 30)),
                child: const Center(child: CircularProgressIndicator()),
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildIdNameAndGender(wildPokemon),
                      _buildShinyBadge(wildPokemon),
                    ],
                  ),
                  _buildImage(wildPokemon),
                  Visibility(
                    visible: vm.catchMode.value,
                    replacement: _buildInitialPanel(wildPokemon),
                    child: _buildCatchModePanel(),
                  )
                ],
              );
            }
          }),
        ),
      ),
    );
  }

  _buildImage(PokemonDetail pokemon) => Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(bottom: AppSize.getSize(24)),
        height: AppSize.getScreenHeight(percent: 45),
        child: DragTarget<String>(
          onAcceptWithDetails: (data) {
            if (data.data == 'pokeball') {
              _checkCatchResult(pokemon);
            }
          },
          onWillAcceptWithDetails: (data) {
            if (data.data == 'pokeball') {
              return true;
            } else {
              return false;
            }
          },
          onLeave: (data) {
            BaseDialog.show(message: 'aim_pokemon'.translate());
          },
          builder: (context, candidateData, rejectedData) {
            return BaseAnimate(
              animationType: AnimationType.slideInRight,
              child: CachedNetworkImage(
                imageUrl: pokemon.shiny! ? pokemon.sprites?.other?.home?.frontShiny ?? '' : pokemon.sprites?.other?.home?.frontDefault ?? '',
              ),
            );
          },
        ),
      );

  _buildIdNameAndGender(PokemonDetail pokemon) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '#${pokemon.id.toString().padLeft(3, '0')}',
            style: AppTextStyle.baseTextStyle(
              fontWeightType: FontWeightType.semiBold,
              fontSize: AppSize.getTextSize(17),
              color: AppColor.primaryColor,
            ),
          ),
          Row(
            children: [
              Text(
                pokemon.name?.toString().toCapitalized() ?? '',
                style: AppTextStyle.baseTextStyle(
                  fontWeightType: FontWeightType.bold,
                  fontSize: AppSize.getTextSize(20),
                ),
              ),
              Icon(
                pokemon.gender == 'Male' ? Icons.male : Icons.female,
                color: pokemon.gender == 'Male' ? AppColor.blue : AppColor.pink,
              ),
            ],
          ),
        ],
      );

  _buildShinyBadge(PokemonDetail pokemon) => Visibility(
        visible: pokemon.shiny ?? false,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppSize.getSize(8),
            vertical: AppSize.getSize(4),
          ),
          decoration: BoxDecoration(
            color: Colors.yellow,
            borderRadius: BorderRadius.circular(AppSize.getSize(8)),
          ),
          child: Text(
            'shiny'.translate(),
            style: AppTextStyle.baseTextStyle(
              fontWeightType: FontWeightType.semiBold,
              fontSize: AppSize.getTextSize(14),
              color: AppColor.black,
            ),
          ),
        ),
      );

  _buildMessage(PokemonDetail pokemon) => Text(
        'message_wild_pokemon'.translateWithParams({'name': pokemon.name ?? ''}),
        style: AppTextStyle.baseTextStyle(
          fontWeightType: FontWeightType.medium,
          fontSize: AppSize.getTextSize(18),
        ),
      );

  _buildActionButtons() => Row(
        children: [
          Expanded(
            child: ItemActionButton(
              action: {
                'icon': AssetUtil.icRun(
                  size: AppSize.getSize(38),
                  color: AppColor.white,
                ),
                'label': 'run'.translate(),
                'tap': () {
                  _encounterViewModel.randomWildPokemon();
                },
              },
            ),
          ),
          SizedBox(width: AppSize.getSize(24)),
          Expanded(
            child: ItemActionButton(
              action: {
                'icon': AssetUtil.icPokeball(
                  size: AppSize.getSize(38),
                  color: AppColor.white,
                ),
                'label': 'catch'.translate(),
                'tap': () {
                  _encounterViewModel.triggerCatchMode();
                },
              },
            ),
          ),
        ],
      );

  _buildInitialPanel(PokemonDetail pokemon) => Container(
        padding: EdgeInsets.all(AppSize.getSize(16)),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(AppSize.getSize(12)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMessage(pokemon),
            SizedBox(height: AppSize.getSize(24)),
            _buildActionButtons(),
          ],
        ),
      );

  _buildCatchModePanel() => Container(
        child: GetUtil.getX<EncounterViewModel>(
          builder: (vm) {
            int fleeRate = vm.fleeRate.value;
            int catchSuccessRate = vm.catchSuccessRate.value;

            return Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: () {
                      _encounterViewModel.triggerCatchMode();
                    },
                    icon: const Icon(
                      Icons.close,
                      color: AppColor.black,
                    ),
                  ),
                ),
                SizedBox(height: AppSize.getSize(16)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          'flee_rate'.translate(),
                          style: AppTextStyle.baseTextStyle(
                            fontWeightType: FontWeightType.semiBold,
                            fontSize: AppSize.getTextSize(16),
                          ),
                        ),
                        Text(
                          '$fleeRate%',
                          style: AppTextStyle.baseTextStyle(
                            fontWeightType: FontWeightType.semiBold,
                            fontSize: AppSize.getTextSize(16),
                          ),
                        ),
                      ],
                    ),
                    Draggable<String>(
                      data: 'pokeball',
                      feedback: AssetUtil.imagePokeball(),
                      childWhenDragging: Opacity(
                        opacity: 0.5,
                        child: AssetUtil.imagePokeball(),
                      ),
                      onDragCompleted: () {
                        // Optionally handle completion
                      },
                      child: AssetUtil.imagePokeball(),
                    ),
                    Column(
                      children: [
                        Text(
                          'success_rate'.translate(),
                          style: AppTextStyle.baseTextStyle(
                            fontWeightType: FontWeightType.semiBold,
                            fontSize: AppSize.getTextSize(16),
                          ),
                        ),
                        Text(
                          '$catchSuccessRate%',
                          style: AppTextStyle.baseTextStyle(
                            fontWeightType: FontWeightType.semiBold,
                            fontSize: AppSize.getTextSize(16),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      );

  void _checkCatchResult(PokemonDetail pokemon) {
    CatchResult catchResult = _encounterViewModel.attemptCatch();

    if (catchResult == CatchResult.success) {
      BaseDialog.show(
        message: 'success_catch'.translateWithParams({'name': pokemon.name ?? ''}),
        positiveAction: () {
          GetUtil.back();
        },
      );
    } else if (catchResult == CatchResult.fail) {
      BaseDialog.show(
        message: 'failed_catch'.translateWithParams({'name': pokemon.name ?? ''}),
      );
    } else {
      BaseDialog.show(
        message: 'flee_catch'.translateWithParams({'name': pokemon.name ?? ''}),
        positiveAction: () {
          GetUtil.back();
        },
      );
    }
  }
}

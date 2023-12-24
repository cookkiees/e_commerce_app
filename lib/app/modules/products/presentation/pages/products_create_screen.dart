import 'dart:io';

import 'package:e_commerce_app/app/common/extensions/app_size_extension.dart';
import 'package:e_commerce_app/app/common/extensions/app_text_extension.dart';
import 'package:e_commerce_app/app/common/utils/app_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../common/extensions/app_carrency_extension.dart';
import '../../../../common/utils/app_loading_button.dart';
import '../../../../components/app_camera_and_gallery_widget.dart';
import '../../../../components/app_elevated_button_widget.dart';
import '../../../../components/app_text_form_field_widget.dart';
import '../../../../config/routers/app_routes.dart';
import '../../../../config/themes/app_colors.dart';
import '../../../extensions/menu_category_extension.dart';
import '../../data/models/product_base_models.dart';
import '../bloc/products_bloc.dart';

class ProductsCreateScreen extends StatefulWidget {
  const ProductsCreateScreen({super.key});

  @override
  State<ProductsCreateScreen> createState() => _ProductsCreateScreenState();
}

class _ProductsCreateScreenState extends State<ProductsCreateScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController stockController = TextEditingController();
  TextEditingController basicPriceController = TextEditingController();
  TextEditingController salePriceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  String nameError = '';
  String categoryError = '';
  String basicPriceError = '';
  String salePriceError = '';
  String descriptionError = '';

  XFile? pickedImage;

  Future<void> openGallery() async {
    final picker = ImagePicker();
    final images = await picker.pickMedia(
      requestFullMetadata: false,
      imageQuality: 100,
    );

    if (images != null) {
      setState(() {
        pickedImage = images;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(
            Icons.arrow_back,
            size: 24.0,
            color: Colors.grey,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
              left: 16, right: 16, bottom: context.viewInsetsBottom / 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              'CREATE A NEW PRODUCTS'.asTitleNormal(),
              'Initiate the Creation of a New Product for Your Inventory'
                  .asSubtitleNormal(color: Colors.grey),
              32.height,
              Row(
                children: [
                  _buildPhotoField(),
                  16.width,
                  Flexible(
                    flex: 2,
                    child: SizedBox(
                      width: context.screenWidth,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: _buildFieldName(),
                          ),
                          12.height,
                          Flexible(
                            child: _builFieldCategory(),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              16.height,
              _buildSalePriceField(),
              12.height,
              _buildDescriptionField(),
            ],
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: (context.viewInsetsBottom > 0) ? 16 : 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BlocConsumer<ProductsBloc, ProductsState>(
              listener: (context, state) {
                switch (state) {
                  case ProductsPostSuccessState():
                    context.pop(true);
                    break;
                  default:
                }
              },
              builder: (context, state) {
                return SizedBox(
                  width: double.infinity,
                  child: AppElevatedButtonWidget(
                    onPressed: isStateToHandle(state)
                        ? () async {
                            final ProductsBloc productsBloc =
                                BlocProvider.of<ProductsBloc>(context);
                            ProductsModels newProduct = ProductsModels(
                              quantity: 1,
                              name: nameController.text,
                              category: categoryController.text,
                              basicPrice: basicPriceController.text,
                              salePrice: salePriceController.text,
                              description: descriptionController.text,
                              imageUrl: pickedImage,
                            );
                            productsBloc.add(
                              ProductsPosEvent(product: newProduct),
                            );
                          }
                        : () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: state is ProductsLoadingState
                        ? buildAppLoadingButton()
                        : 'Create Products'.asLabelButton(color: Colors.white),
                  ),
                );
              },
            ),
            4.height,
            Center(
              child: 'Make sure all fields are filled in correctly'
                  .asSubtitleSmall(
                color: Colors.grey,
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
      ),
    );
  }

  getErrorMessage(String error) {
    return Text(
      error,
      style: const TextStyle(
        fontSize: 11,
        color: Colors.red,
        fontWeight: FontWeight.w300,
      ),
    );
  }

  Column _buildDescriptionField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            'Description'.asSubtitleNormal(
              fontWeight: FontWeight.w400,
            ),
            if (descriptionError.isNotEmpty) getErrorMessage(descriptionError)
          ],
        ),
        4.height,
        SizedBox(
          height: 70,
          child: AppTextFormFieldWidget(
            maxLength: 50,
            controller: descriptionController,
            hintText: 'Enter a description',
            style: const TextStyle(fontSize: 12),
            onChanged: (value) {
              descriptionController.text = value;
              setState(() {
                if (descriptionController.text.isEmpty) {
                  descriptionError = ' (Is Required)';
                } else {
                  descriptionError = '';
                }
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSalePriceField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            'Sale Price'.asSubtitleNormal(
              fontWeight: FontWeight.w400,
            ),
            if (salePriceError.isNotEmpty) getErrorMessage(salePriceError)
          ],
        ),
        4.height,
        SizedBox(
          height: 44,
          child: AppTextFormFieldWidget(
            maxLines: 1,
            inputFormatters: [CurrencyInputFormatter()],
            hintText: 'Enter a sale price',
            style: const TextStyle(fontSize: 12),
            controller: salePriceController,
            onChanged: (value) {
              salePriceController.text = value;
              setState(() {
                if (salePriceController.text.isEmpty) {
                  salePriceError = ' (Is Required)';
                } else {
                  salePriceError = '';
                }
              });
            },
          ),
        ),
      ],
    );
  }

  Flexible _buildBasicPriceField() {
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              'Basic Price'.asSubtitleNormal(
                fontWeight: FontWeight.w400,
              ),
              if (basicPriceError.isNotEmpty) getErrorMessage(basicPriceError)
            ],
          ),
          4.height,
          SizedBox(
            height: 44,
            child: AppTextFormFieldWidget(
              maxLines: 1,
              hintText: 'Enter a basic price',
              inputFormatters: [CurrencyInputFormatter()],
              style: const TextStyle(fontSize: 12),
              controller: basicPriceController,
              onChanged: (value) {
                basicPriceController.text = value;
                setState(() {
                  if (basicPriceController.text.isEmpty) {
                    basicPriceError = ' (Is Required)';
                  } else {
                    basicPriceError = '';
                  }
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Column _buildStcokField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            'Stock'.asSubtitleNormal(
              fontWeight: FontWeight.w400,
            ),
            ' (Opsional)'.asSubtitleSmall(
              color: Colors.grey,
              fontWeight: FontWeight.w400,
            ),
          ],
        ),
        4.height,
        SizedBox(
          height: 44,
          child: AppTextFormFieldWidget(
            maxLines: 1,
            hintText: 'Enter a stock',
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'\d')),
            ],
            style: const TextStyle(fontSize: 12),
            controller: stockController,
          ),
        ),
      ],
    );
  }

  Widget _buildPhotoField() {
    return InkWell(
      onTap: () {
        context.appBottomSheet(
          bottomSheetContent: AppCameraAndGalleryWidget(
            onTapCamera: () async {
              var result = await context.pushNamed(AppRoutes.camera.name);
              if (result != null) {
                result as XFile;
                setState(() {
                  pickedImage = result;
                });
              }
            },
            onTapGallery: () => openGallery(),
          ),
        );
      },
      child: Container(
        height: 142,
        width: 142,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: pickedImage == null
            ? const Icon(
                Icons.photo,
                size: 32.0,
                color: Colors.white,
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.file(
                  File(pickedImage!.path),
                  fit: BoxFit.cover,
                ),
              ),
      ),
    );
  }

  bool isStateToHandle(ProductsState state) {
    return state is ProductsInitialState ||
        state is ProductsFailureState ||
        state is ProductsErrorState;
  }

  Widget _builFieldCategory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            'Category'.asSubtitleNormal(
              fontWeight: FontWeight.w400,
            ),
            if (categoryError.isNotEmpty) getErrorMessage(categoryError)
          ],
        ),
        4.height,
        SizedBox(
          height: 44,
          child: AppTextFormFieldWidget(
            maxLines: 1,
            readOnly: true,
            controller: categoryController,
            hintText: 'Enter a category',
            onChanged: (value) {
              categoryController.text = value;
              setState(() {
                if (categoryController.text.isEmpty) {
                  categoryError = ' (Is Required)';
                } else {
                  categoryError = '';
                }
              });
            },
            style: const TextStyle(fontSize: 10),
            suffixIcon: PopupMenuButton<MenuCategory>(
              color: Colors.white,
              elevation: 1,
              surfaceTintColor: Colors.white,
              icon: const Icon(
                Icons.keyboard_arrow_down,
                color: Colors.grey,
                size: 18,
              ),
              offset: const Offset(0, 46),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              onSelected: (MenuCategory choice) {
                setState(() {
                  categoryController.text = choice.name;
                });
              },
              itemBuilder: (BuildContext context) {
                return MenuCategory.values.map((menuOption) {
                  return PopupMenuItem<MenuCategory>(
                    value: menuOption,
                    child: SizedBox(
                      width: 140,
                      child: Text(
                        menuOption.name,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  );
                }).toList();
              },
            ),
          ),
        ),
      ],
    );
  }

  Column _buildFieldName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            'Name'.asSubtitleNormal(
              fontWeight: FontWeight.w400,
            ),
            if (nameError.isNotEmpty) getErrorMessage(nameError)
          ],
        ),
        4.height,
        SizedBox(
          height: 44,
          width: context.screenWidth,
          child: AppTextFormFieldWidget(
            maxLines: 1,
            hintText: 'Enter a name products',
            controller: nameController,
            style: const TextStyle(fontSize: 12),
            onChanged: (value) {
              nameController.text = value;
              setState(() {
                if (nameController.text.isEmpty) {
                  nameError = ' (Is Required)';
                } else {
                  nameError = '';
                }
              });
            },
          ),
        ),
      ],
    );
  }
}

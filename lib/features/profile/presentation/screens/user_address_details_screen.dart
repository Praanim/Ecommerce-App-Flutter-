import 'package:eccomerce_frontend/core/constants/constants.dart';
import 'package:eccomerce_frontend/core/constants/text_constants.dart';
import 'package:eccomerce_frontend/core/shared/custom_app_bar.dart';
import 'package:eccomerce_frontend/core/utils/context_extension.dart';
import 'package:eccomerce_frontend/core/utils/gap.dart';
import 'package:eccomerce_frontend/core/widgets/custom_elevated_button.dart';
import 'package:eccomerce_frontend/features/auth/data/models/user.dart';
import 'package:eccomerce_frontend/features/auth/presentation/providers/auth_providers.dart';
import 'package:eccomerce_frontend/features/auth/presentation/widgets/text_form_field.dart';
import 'package:eccomerce_frontend/features/profile/presentation/widgets/profile_common_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class UserAddressDetailsScreen extends StatelessWidget {
  const UserAddressDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text(TextConstants.profileText),
      ),
      body: Padding(
        padding: const EdgeInsets.all(
          AppConstants.pad16,
        ),
        child: Column(
          children: [
            const ProfileCommonHeader(
              icon: IconConstants.homeIcon,
              text: " Delivery Address",
            ),
            VerticalGap.xxl,
            Consumer(builder: (context, ref, child) {
              final userDetails = ref.watch(userDataProvider);

              //returning widget
              return _AddUserAddressWidget(userDetails, (
                address,
                state,
                city,
                mobile,
              ) async {
                //calling update user function
                ref
                    .read(userDataProvider.notifier)
                    .updateUserDetails(
                      addressModel: AddressModel(
                        address: address,
                        state: state,
                        city: city,
                      ),
                      mobile: mobile,
                    )
                    .then((message) {
                  //show Snackbar and pop
                  context.showSnackBar(
                      message: message, toastType: ToastType.success);
                  if (context.canPop()) {
                    context.pop();
                  }
                });
              });
            })
          ],
        ),
      ),
    );
  }
}

class _AddUserAddressWidget extends StatefulWidget {
  final UserModel? userModel;

  final Future<void> Function(
      String address, String state, String city, String mobile) onButtonCliked;

  const _AddUserAddressWidget(this.userModel, this.onButtonCliked);

  @override
  State<_AddUserAddressWidget> createState() => _AddUserAddressWidgetState();
}

class _AddUserAddressWidgetState extends State<_AddUserAddressWidget> {
  late final TextEditingController _addressController;
  late final TextEditingController _cityController;
  late final TextEditingController _stateController;
  late final TextEditingController _countryController;
  late final TextEditingController _phoneNumController;

  @override
  void initState() {
    super.initState();
    final userModel = widget.userModel;
    _initializeTextEditingController(userModel);
    _countryController = TextEditingController(text: 'Nepal');
  }

  void _initializeTextEditingController(UserModel? userModel) {
    if (userModel?.address == null || userModel?.mobile == null) {
      _addressController = TextEditingController();
      _cityController = TextEditingController();
      _stateController = TextEditingController();
      _phoneNumController = TextEditingController();
    } else {
      _addressController =
          TextEditingController(text: userModel!.address!.address);
      _cityController = TextEditingController(text: userModel.address!.city!);
      _stateController = TextEditingController(text: userModel.address!.state!);
      _phoneNumController = TextEditingController(text: userModel.mobile!);
    }
  }

  @override
  void dispose() {
    _addressController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _countryController.dispose();
    _phoneNumController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextFormField(
            textEditingController: _addressController,
            labelText: "Tole, Ward & Municipality"),
        VerticalGap.l,
        CustomTextFormField(
            textEditingController: _cityController, labelText: "City"),
        VerticalGap.l,
        Row(
          children: [
            Expanded(
              child: CustomTextFormField(
                  textEditingController: _stateController, labelText: "State"),
            ),
            HorizontalGap.s,
            Expanded(
                child: CustomTextFormField(
              textEditingController: _countryController,
              labelText: 'Country',
              readOnly: true,
            )),
          ],
        ),
        VerticalGap.l,
        CustomTextFormField(
          textEditingController: _phoneNumController,
          labelText: "Phone Number ",
          prefixText: "+977",
          keyboardInputType: TextInputType.phone,
        ),
        VerticalGap.xxl,
        SizedBox(
          width: double.infinity,
          child: CustomElevatedButton(
            onPressed: () async {
              //add the address to the db
              widget.onButtonCliked(
                  _addressController.text,
                  _stateController.text,
                  _cityController.text,
                  _phoneNumController.text);
            },
            title: TextConstants.addAddressText,
          ),
        )
      ],
    );
  }
}

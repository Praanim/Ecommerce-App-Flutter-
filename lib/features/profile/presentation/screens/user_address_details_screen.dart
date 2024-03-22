import 'package:eccomerce_frontend/core/constants/constants.dart';
import 'package:eccomerce_frontend/core/constants/text_constants.dart';
import 'package:eccomerce_frontend/core/shared/custom_app_bar.dart';
import 'package:eccomerce_frontend/core/utils/gap.dart';
import 'package:eccomerce_frontend/core/widgets/custom_elevated_button.dart';
import 'package:eccomerce_frontend/features/auth/presentation/widgets/text_form_field.dart';
import 'package:eccomerce_frontend/features/profile/presentation/widgets/profile_common_header.dart';
import 'package:flutter/material.dart';

class UserAddressDetailsScreen extends StatelessWidget {
  const UserAddressDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text(TextConstants.profileText),
      ),
      body: Padding(
        padding: EdgeInsets.all(
          AppConstants.pad16,
        ),
        child: Column(
          children: [
            ProfileCommonHeader(
              icon: IconConstants.homeIcon,
              text: " Delivery Address",
            ),
            VerticalGap.xxl,
            _AddUserAddressWidget()
          ],
        ),
      ),
    );
  }
}

class _AddUserAddressWidget extends StatefulWidget {
  const _AddUserAddressWidget();

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
    _addressController = TextEditingController();
    _cityController = TextEditingController();
    _stateController = TextEditingController();
    _countryController = TextEditingController(text: 'Nepal');
    _phoneNumController = TextEditingController();
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
            onPressed: () {
              //add the address to the db
            },
            title: TextConstants.addAddressText,
          ),
        )
      ],
    );
  }
}

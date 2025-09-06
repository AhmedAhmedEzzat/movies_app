import 'package:flutter/material.dart';
import 'package:movies_app/core/theme/color_pallete.dart';
import 'package:movies_app/core/widgets/custom_button.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/widgets/custom_text_form_field.dart';

class ForgetPassword extends StatefulWidget {
  static const String routeName = '/forget_password';
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Forget Password'),
        ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(AppAssets.forgetPassword,height: MediaQuery.of(context).size.height*0.5,),
              CustomTextFormField(
                hintText: 'Email',
                prefixIcon: Image.asset(AppAssets.emailIcon,),
              ),
              SizedBox(height: 20),
              CustomButton(child: Text('Verify Email',style:theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w400,color: ColorPallete.textBlackColor)), onTap: (){})
            ],
          ),
        ),
      ),
    );
  }
}

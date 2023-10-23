import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../config/constant.dart';
import '../../../../config/utils.dart';
import '../../../../config/validation.dart';
import '../../../../controllers/main/edit_profile_controller.dart';
import '../../../../models/main/profile_model.dart';
import '../../../../widgets/src/custom_single_child_scroll_view.dart';
import '../../../../widgets/src/custom_text_field.dart';
import '../../../../widgets/src/custom_widget.dart';

class EditProfileScreen extends StatefulWidget {
  final ProfileModel profile;

  const EditProfileScreen({Key? key, required this.profile}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _controller = EditProfileController.to;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.controllerFullName.text = widget.profile.fullName;
    _controller.controllerEmail.text = widget.profile.email;
    _controller.controllerSyndicateNumber.text = widget.profile.syndicateNumber;
    _controller.controllerHomeAddress.text = widget.profile.homeAddress;
    _controller.controllerWorkAddress.text = widget.profile.workAddress;
  }

  @override
  Widget build(BuildContext context) {
    return CustomWidget(
      alignment: Alignment.topCenter,
      appBar: AppBar(
        title: Text(
          'Edit Profile'.tr,
          style: kStyleTextTitle.copyWith(color: Colors.black),
        ),
      ),
      child: GetBuilder<EditProfileController>(
        builder: (controller) => CustomSingleChildScrollView(
          child: Form(
            key: _controller.keyForm,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    _controller.selectImage();
                  },
                  child: CircleAvatar(
                    radius: 60.0.r,
                    backgroundImage: (_controller.image.value == null
                        ? Utils.isNotEmpty(widget.profile.image)
                        ? CachedNetworkImageProvider(widget.profile.image)
                        : const AssetImage('assets/images/profile.png')
                        : MemoryImage(_controller.image.value!.bytes!)) as ImageProvider<Object>,
                    backgroundColor: Colors.grey,
                  ),
                ),
                SizedBox(height: 5.h),
                CustomTextField(
                  label: Text("Full Name".tr),
                  controller: _controller.controllerFullName,
                  validator: (value) => Validation.isRequired(value),
                ),
                CustomTextField(
                  label: Text("Email".tr),
                  controller: _controller.controllerEmail,
                  validator: (value) => Validation.isRequired(value),
                ),
                CustomTextField(
                  label: Text("Syndicate Number".tr),
                  controller: _controller.controllerSyndicateNumber,
                  validator: (value) => Validation.isRequired(value),
                ),
                CustomTextField(
                  label: Text("Home Address".tr),
                  controller: _controller.controllerHomeAddress,
                  validator: (value) => Validation.isRequired(value),
                ),
                CustomTextField(
                  label: Text("Work Address".tr),
                  controller: _controller.controllerWorkAddress,
                  validator: (value) => Validation.isRequired(value),
                ),
                ElevatedButton(
                  child: Text('Save Changes'.tr),
                  onPressed: () {
                    _controller.changeProfile();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

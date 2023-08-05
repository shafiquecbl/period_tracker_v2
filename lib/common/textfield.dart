import 'package:flutter/material.dart';
import 'package:food_delivery/utils/style.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? labelText, hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool obscureText;
  final EdgeInsetsGeometry? padding;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final void Function()? onTap;

  const CustomTextField(
      {required this.controller,
      this.hintText,
      this.labelText,
      this.suffixIcon,
      this.prefixIcon,
      this.obscureText = false,
      this.padding,
      this.validator,
      this.onChanged,
      this.onSubmitted,
      this.keyboardType,
      this.textInputAction,
      this.onTap,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsetsDirectional.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // title
          if (labelText != null) ...[
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(labelText!),
            ),
            const SizedBox(height: 5),
          ],
          TextFormField(
            controller: controller,
            obscureText: obscureText,
            validator: validator,
            onChanged: onChanged,
            onFieldSubmitted: onSubmitted,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            onTap: onTap,
            decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                prefixIcon: prefixIcon,
                labelStyle: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Theme.of(context).hintColor),
                hintText: hintText,
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Theme.of(context).hintColor),
                enabledBorder: border(context),
                focusedBorder:
                    border(context, color: Theme.of(context).primaryColor),
                errorBorder:
                    border(context, color: Theme.of(context).colorScheme.error),
                focusedErrorBorder: border(context),
                filled: true,
                fillColor: Theme.of(context).cardColor,
                contentPadding: const EdgeInsets.all(15),
                suffixIcon: suffixIcon),
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }

  InputBorder border(BuildContext context, {Color? color}) =>
      OutlineInputBorder(
        borderSide: BorderSide(
          color: color ?? Theme.of(context).cardColor,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(radius),
      );
}

class CustomDropDown extends StatelessWidget {
  final List<DropdownMenuItem> items;
  final Function(dynamic) onChanged;
  final String? labelText, hintText;
  final Widget? suffixIcon;
  final EdgeInsetsGeometry? padding;
  const CustomDropDown(
      {required this.items,
      required this.onChanged,
      this.hintText,
      this.labelText,
      this.suffixIcon,
      this.padding,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // title
          if (labelText != null) ...[
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                labelText!,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Theme.of(context).hintColor),
              ),
            ),
            const SizedBox(height: 5),
          ],
          DropdownButtonFormField(
            decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                labelText: hintText,
                labelStyle: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Theme.of(context).hintColor),
                enabledBorder: border(context),
                focusedBorder:
                    border(context, color: Theme.of(context).primaryColor),
                errorBorder:
                    border(context, color: Theme.of(context).colorScheme.error),
                focusedErrorBorder: border(context),
                filled: true,
                fillColor: Theme.of(context).cardColor,
                contentPadding: const EdgeInsets.all(15),
                suffixIcon: suffixIcon),
            style: Theme.of(context).textTheme.bodyLarge,
            items: items,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  InputBorder border(BuildContext context, {Color? color}) =>
      OutlineInputBorder(
        borderSide: BorderSide(
          color: color ?? Theme.of(context).cardColor,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(5),
      );
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

/// A class that represents send button widget.
class SendButton extends StatelessWidget {
  /// Creates send button widget.
  const SendButton({
    super.key,
    required this.onPressed,
    this.padding = EdgeInsets.zero,
  });

  /// Callback for send button tap event.
  final VoidCallback onPressed;

  /// Padding around the button.
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) => GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: onPressed,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minHeight: 24,
          ),
          child: Padding(
            //padding: padding,
            padding: const EdgeInsets.only(right: 4),
            child: SvgPicture.string(
              '<svg width="32" height="32" viewBox="0 0 32 32" fill="none" xmlns="http://www.w3.org/2000/svg"><circle cx="16" cy="16" r="16" fill="#1D9BF0"/><path d="M9.27681 8.19605C9.39622 8.09232 9.5437 8.02631 9.70061 8.00638C9.85752 7.98644 10.0168 8.01347 10.1584 8.08405L24.5578 15.2838C24.6909 15.3501 24.8029 15.4523 24.8812 15.5787C24.9595 15.7052 25.0009 15.851 25.0009 15.9997C25.0009 16.1485 24.9595 16.2943 24.8812 16.4208C24.8029 16.5472 24.6909 16.6494 24.5578 16.7157L10.1584 23.9154C10.0168 23.9863 9.85746 24.0135 9.70043 23.9937C9.5434 23.9739 9.39576 23.908 9.2762 23.8043C9.15665 23.7006 9.07054 23.5638 9.02878 23.4111C8.98703 23.2584 8.99149 23.0968 9.04162 22.9467L11.0911 16.7997H15.4006C15.6127 16.7997 15.8162 16.7154 15.9662 16.5654C16.1163 16.4154 16.2005 16.2119 16.2005 15.9997C16.2005 15.7876 16.1163 15.5841 15.9662 15.4341C15.8162 15.2841 15.6127 15.1998 15.4006 15.1998H11.0911L9.04082 9.05281C8.99095 8.90275 8.98668 8.74127 9.02854 8.58878C9.0704 8.43628 9.15732 8.29962 9.27681 8.19605Z" fill="white"/></svg>',
            ),
          ),
        ),
      );
}

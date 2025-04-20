import 'package:flutter/material.dart';

class ComposerActionButton {
  final IconData icon;
  final String title;
  final VoidCallback onPressed;
  final bool destructive;

  const ComposerActionButton({
    required this.icon,
    required this.title,
    required this.onPressed,
    this.destructive = false,
  });
}

class ComposerActionBar extends StatelessWidget {
  final List<ComposerActionButton> buttons;

  const ComposerActionBar({super.key, required this.buttons});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            for (var i = 0; i < buttons.length; i++) ...[
              if (i > 0) const SizedBox(width: 8),
              OutlinedButton.icon(
                icon: Icon(
                  buttons[i].icon,
                  color: buttons[i].destructive ? Colors.red : null,
                ),
                label: Text(
                  buttons[i].title,
                  style: TextStyle(
                    color: buttons[i].destructive ? Colors.red : null,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: buttons[i].destructive ? Colors.red : null,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                ),
                onPressed: buttons[i].onPressed,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

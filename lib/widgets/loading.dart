import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background dim
        ModalBarrier(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
          dismissible: false,
        ),
        // Loading indicator
        const Center(
          child: CircularProgressIndicator(),
        ),
      ],
    );
  }

}
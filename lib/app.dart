import 'package:flutter/material.dart';
import 'package:radio_upp/ui/components/header/header.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: Header(MediaQuery.of(context)),
          ),
        ],
      ),
    );
  }
}

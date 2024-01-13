import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late TextEditingController textController;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController(
      text:
          'My code fails, I do not know why.\nMy code works, I do not know why.\nText in other scripts: Tamaziɣt Taqbaylit, 中文(简体), Čeština, Беларуская, Ελληνικά, עברית, Русский, བོད་ཡིག, Norsk bokmål.',
    );
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final children = [
      Row(
        children: [
          Expanded(
            child: FilledButton(
              onPressed: () {},
              child: const Text(
                'Filled Button',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: OutlinedButton(
              onPressed: () {},
              child: const Text(
                'Outlined Button',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Username',
              ),
            ),
          ),
        ],
      ),
      const TextField(
        enabled: false,
        onChanged: null,
        decoration: InputDecoration(
          labelText: 'Disabled',
        ),
      ),
      const TextField(
        obscureText: true,
        decoration: InputDecoration(
          labelText: 'Password',
        ),
      ),
      const TextField(
        decoration: InputDecoration(
          errorText: "You're doing it wrong",
        ),
      ),
      TextField(
        keyboardType: TextInputType.multiline,
        controller: textController,
        minLines: 5,
        maxLines: 5,
      ),
      const DropdownMenu(
        dropdownMenuEntries: [
          DropdownMenuEntry(value: 1, label: '1'),
          DropdownMenuEntry(value: 2, label: '2'),
          DropdownMenuEntry(value: 3, label: '3'),
        ],
      ),
    ];

    return Scaffold(
        //backgroundColor: AppTheme.dark,
        body: Padding(
      padding: const EdgeInsets.all(18.0),
      child: ListView.separated(
        itemBuilder: (context, index) => children[index],
        separatorBuilder: (context, index) => const SizedBox(height: 15),
        itemCount: children.length,
      ),
    ));
  }
}

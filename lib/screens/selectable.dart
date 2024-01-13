import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:yaru_widgets/yaru_widgets.dart';
import 'containers.dart';

class SelectableContainerPage extends StatefulWidget {
  const SelectableContainerPage({Key? key}) : super(key: key);

  @override
  State<SelectableContainerPage> createState() =>
      _SelectableContainerPageState();
}

class _SelectableContainerPageState extends State<SelectableContainerPage> {
  int selectedOption = 1;
  final outerController = ScrollController();
  final innerController = ScrollController();
  final List<bool> _isItemSelectedList = [
    false,
    false,
    false,
    false,
    false,
  ];

  final Map<String, bool> _pizza = {
    "Margarita": false,
    "Classic": false,
    "Vegetable": false,
    "Country": false,
    "Karst": false,
    "Seafood": false,
  };

  final List<Map<String, dynamic>> _pizzaList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(kYaruPagePadding),
        child: Row(
          children: [
            //first column
            Expanded(
              child: Column(
                children: [
                  SizedBox(
                      height: 100,
                      child: Listener(
                        onPointerSignal: (event) {
                          if (event is PointerScrollEvent) {
                            final offset = event.scrollDelta.dy;
                            innerController
                                .jumpTo(innerController.offset + offset);
                            //outerController.jumpTo(outerController.offset - offset);
                          }
                        },
                        child: ListView(
                          controller: innerController,
                          scrollDirection: Axis.horizontal,
                          children: _pizza.entries.map((entry) {
                            int index = _pizza.keys.toList().indexOf(entry.key);
                            return YaruSelectableContainer(
                              selected: entry.value,
                              onTap: () {
                                setState(() {
                                  for (int i = 0; i < _pizza.length; i++) {
                                    if (i == index) {
                                      _pizza[entry.key] = !_pizza[entry.key]!;
                                    } else {
                                      _pizza[_pizza.keys.elementAt(i)] = false;
                                    }
                                  }
                                });
                                dialogBuilder(
                                        context, 'assets/${entry.key}.jpg')
                                    .then((value) {
                                  setState(() {
                                    if (value['imagePath'] != '') {
                                      _pizzaList.add({
                                        'imagePath': value['imagePath'],
                                        'text': Map<String, bool>.from(
                                            value['text'])
                                      });
                                    }
                                  });
                                });
                              },
                              child: Image.asset(
                                'assets/${entry.key}.jpg',
                                filterQuality: FilterQuality.low,
                                fit: BoxFit.fill,
                                height: 100,
                              ),
                            );
                          }).toList(),
                        ),
                      )),
                  const Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Name',
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Location',
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'City',
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Expanded(
                        child: DropdownMenu(
                          width: 200,
                          label: Text('Payment method'),
                          dropdownMenuEntries: [
                            DropdownMenuEntry(value: 1, label: 'Card'),
                            DropdownMenuEntry(value: 2, label: 'Cash'),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Text(
                              'Student voucher:',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            Radio<int>(
                              value: 1,
                              groupValue: selectedOption,
                              onChanged: (value) {
                                setState(() {
                                  selectedOption = value!;
                                });
                              },
                            ),
                            const Text('Yes'),
                            Radio<int>(
                              value: 2,
                              groupValue: selectedOption,
                              onChanged: (value) {
                                setState(() {
                                  selectedOption = value!;
                                });
                              },
                            ),
                            const Text('No'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            //second column
            Container(
              width: 400,
              child: Column(
                children: [
                  Column(
                    children: _pizzaList.map((pizza) {
                      String imagePath = pizza['imagePath'];
                      Map<String, bool> text = pizza['text'];

                      List<String> trueKeys = text.entries
                          .where((entry) => entry.value)
                          .map((entry) => entry.key)
                          .toList();

                      return Card(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(5.0),
                                child: Image.asset(
                                  imagePath,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  setState(() {
                                    _pizzaList.remove(pizza);
                                  });
                                },
                              ),
                              title: Text(imagePath
                                  .replaceFirst('assets/', '')
                                  .replaceAll('.jpg', '')),
                              subtitle:
                                  Text('Additions: ${trueKeys.join(', ')}'),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Name',
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Location',
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'City',
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: DropdownMenu(
                      width: 200,
                      label: Text('Payment method'),
                      dropdownMenuEntries: [
                        DropdownMenuEntry(value: 1, label: 'Card'),
                        DropdownMenuEntry(value: 2, label: 'Cash'),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    children: [
                      Text(
                        'Student voucher:',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Radio<int>(
                        value: 1,
                        groupValue: selectedOption,
                        onChanged: (value) {
                          setState(() {
                            selectedOption = value!;
                          });
                        },
                      ),
                      const Text('Yes'),
                      Radio<int>(
                        value: 2,
                        groupValue: selectedOption,
                        onChanged: (value) {
                          setState(() {
                            selectedOption = value!;
                          });
                        },
                      ),
                      const Text('No'),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    margin: const EdgeInsets.all(10.0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text('Order'),
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(Size(
                              double.infinity,
                              50)), // Adjust the height as needed
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

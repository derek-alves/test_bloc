import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/components/input_widget.dart';
import 'package:test/screens/home/bloc/sort_numbers_bloc.dart';

import './bloc/sort_numbers_bloc.dart';
import './bloc/sort_numbers_event.dart';
import './bloc/sort_numbers_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  int _counter = 0;
  List _inputs = [];

  _onUpdate(int index, String value) {
    if (_inputs.asMap().containsKey(index)) {
      _inputs[index] = value;
    } else {
      _inputs.add(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<SortNumbersBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teste flutter'),
        actions: [
          TextButton(
              onPressed: () {
                bloc.add(SortNumberInsertEvent(data: _inputs));

                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: const Text(
                "Filtrar",
                style: TextStyle(color: Colors.white),
              )),
          IconButton(
              onPressed: () {
                setState(() {
                  _counter = 0;
                  _inputs = [];
                  controller.clear();
                  bloc.add(SortNumberResetEvent());
                });
              },
              icon: const Icon(Icons.refresh)),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Informe um numero da classe dos inteiros"),
                        Row(
                          children: [
                            Flexible(
                                child: Form(
                              key: _formKey,
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Informe algum valor";
                                  }
                                  if (int.parse(value) < 0) {
                                    return "Somente numeros positivos";
                                  }

                                  if (int.parse(value) == 0) {
                                    return "Somente numeros a partir de 1";
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.number,
                                controller: controller,
                              ),
                            )),
                            IconButton(
                                onPressed: () => setState(() {
                                      _formKey.currentState!.validate();
                                      _counter = int.parse(controller.text);
                                    }),
                                icon: const Icon(Icons.add)),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              BlocBuilder<SortNumbersBloc, SortNumbersState>(
                  bloc: bloc,
                  builder: (context, state) {
                    if (state is SortNumbersError) {
                      return Text(state.message,
                          style: const TextStyle(color: Colors.red));
                    }

                    if (state is SortNumbersLoading) {
                      return const Expanded(
                          child: Center(
                        child: CircularProgressIndicator(),
                      ));
                    }

                    if (state is SortNumbersSuccess) {
                      return Expanded(
                        child: ListView.builder(
                          shrinkWrap: false,
                          itemCount: state.data.length,
                          itemBuilder: (context, index) {
                            return Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                height: 50,
                                child: Card(
                                  child: Center(
                                    child: Text(state.data[index].toString()),
                                  ),
                                ));
                          },
                        ),
                      );
                    }

                    return _counter > 0
                        ? Expanded(
                            child: ListView.builder(
                              shrinkWrap: false,
                              itemCount: _counter,
                              itemBuilder: (context, index) {
                                return InputWidget(
                                    index: index, onUpdate: _onUpdate);
                              },
                            ),
                          )
                        : Container();
                  })
            ],
          ),
        ),
      ),
    );
  }
}

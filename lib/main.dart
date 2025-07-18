import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pearl/Item.dart';
import 'package:pearl/bloc/bloc_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: BlocProvider(
        create: (context) => BlocBloc(),
        child: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<BlocBloc>(context).add(LoadItems());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pearl Assignment")),
      body: BlocBuilder<BlocBloc, BlocState>(
        builder: (context, state) {
          if (state is BlocFailed) {
            return Container(child: Text("error"));
          } else if (state is BlocLoading)
            return Center(child: CircularProgressIndicator());
          else if (state is BlocSuccess) {
            return ListView.builder(
              itemCount: state.item.length,
              itemBuilder: (c, i) {
                Item item = state.item[i];
                return ListTile(
                  title: Row(
                    children: [
                      Text(item.title),
                      SizedBox(width: 15),
                      Container(
                        padding: EdgeInsets.all(2),
                        child: Text(item.tag.name),
                        color: tagColor[item.tag],
                      ),
                    ],
                  ),
                  trailing: Switch(
                    value: item.isFav,
                    onChanged: (value) {
                      setState(() {
                        item.isFav = value;
                      });
                    },
                  ),
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}

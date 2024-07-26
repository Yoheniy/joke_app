import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  fetchJoke() async{
    final response=
    await Dio().get('https://official-joke-api.appspot.com/random_joke');
 
    return response.data;

  }
  @override
  Widget build(BuildContext context) {
    var futureJoke = fetchJoke();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed:() {
            setState(() {
              
              futureJoke=fetchJoke();
            });
          }, 
          icon: const Icon(Icons.refresh),
          ),
        title: const Text('Joker'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: FutureBuilder(
          future:futureJoke,
          builder:(context,AsyncSnapshot snapshot){
          if(snapshot.hasData) {
            final joke = snapshot.data;
            final String setup=joke['setup'];
            final String punchline=joke['punchline'];
            return  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Setup:$setup',
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
                ),
                const SizedBox(
                  height:20,

                ),
                Text(
                  'punchline: $punchline',
                  style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
                )
              ],
            );
          }
          return const Center(
            child:CircularProgressIndicator(),
            );
        },),
      ),
    );
  }
}
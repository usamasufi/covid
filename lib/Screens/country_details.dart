import 'package:covid/Screens/home_screen.dart';
import 'package:flutter/material.dart';

class CountryDetails extends StatefulWidget {
  final String image, name;
  final int totalCases,
      totalDeaths,
      totalRecovered,
      active,
      critical,
      todayRecovered,
      test;
  const CountryDetails(
      {super.key,
      required this.image,
      required this.name,
      required this.totalCases,
      required this.totalDeaths,
      required this.totalRecovered,
      required this.active,
      required this.critical,
      required this.todayRecovered,
      required this.test});

  @override
  State<CountryDetails> createState() => _CountryDetailsState();
}

class _CountryDetailsState extends State<CountryDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [Stack(
          alignment: Alignment.topCenter,
          children: [
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*.07),
            child: Card(child: Column(children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .06,
              ),
              ReuseableRow(title: 'Cases', value: widget.totalCases.toString()),
              ReuseableRow(title: 'Deaths', value: widget.totalDeaths.toString()),
              ReuseableRow(title: 'Recovered', value: widget.totalRecovered.toString()),
              ReuseableRow(title: 'Active', value: widget.active.toString()),
              ReuseableRow(title: 'Critical', value: widget.critical.toString()),
              ReuseableRow(title: 'Today Recovered', value: widget.todayRecovered.toString()),
              ReuseableRow(title: 'Tests', value: widget.test.toString()),
            ],),),
          ),
            CircleAvatar(backgroundImage: NetworkImage(widget.image),radius: 60,)
        ],)],
      ),
    );
  }
}

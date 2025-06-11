// import 'package:covid/Screens/country_details.dart';
// import 'package:covid/Services/states_services.dart';
// import 'package:flutter/material.dart';
// import 'package:shimmer/shimmer.dart';
//
// class CountriesList extends StatefulWidget {
//   const CountriesList({super.key});
//
//   @override
//   State<CountriesList> createState() => _CountriesListState();
// }
//
// class _CountriesListState extends State<CountriesList> {
//   TextEditingController searchController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     StatesServices statesServices = StatesServices();
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: TextFormField(
//               controller: searchController,
//               onChanged: (value) {
//                 setState(() {});
//               },
//               decoration: InputDecoration(
//                   contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
//                   hintText: 'Search with Country Name',
//                   suffixIcon: const Icon(Icons.search),
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(50))),
//             ),
//           ),
//           Expanded(
//               child: FutureBuilder(
//                   future: statesServices.countriesListApi(),
//                   builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
//                     if (!snapshot.hasData) {
//                       return ListView.builder(
//                           itemCount: 5,
//                           itemBuilder: (context, index) {
//                             return Shimmer.fromColors(
//                               baseColor: Colors.grey.shade600,
//                               highlightColor: Colors.grey.shade100,
//                               child: Column(
//                                 children: [
//                                   ListTile(
//                                     title: Container(
//                                       height: 10,
//                                       width: 80,
//                                       color: Colors.white,
//                                     ),
//                                     subtitle: Container(
//                                       height: 10,
//                                       width: 80,
//                                       color: Colors.white,
//                                     ),
//                                     leading: Container(
//                                       height: 50,
//                                       width: 70,
//                                       color: Colors.white,
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             );
//                           });
//                     } else {
//                       return ListView.builder(
//                           itemCount: snapshot.data!.length,
//                           itemBuilder: (context, index) {
//                             String name = snapshot.data![index]['country'];
//                             if (searchController.text.isEmpty) {
//                               return Column(
//                                 children: [
//                                   InkWell(
//                                     onTap: () {
//                                       Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                             builder: (context) =>
//                                                 CountryDetails(
//                                               image: snapshot.data![index]
//                                                   ['countryInfo']['flag'],
//                                               name: snapshot.data![index]
//                                                   ['country'],
//                                               totalCases: snapshot.data![index]
//                                                   ['cases'],
//                                               totalDeaths: snapshot.data![index]
//                                                   ['deaths'],
//                                               totalRecovered: snapshot
//                                                   .data![index]['recovered'],
//                                               active: snapshot.data![index]
//                                                   ['active'],
//                                               critical: snapshot.data![index]
//                                                   ['critical'],
//                                               todayRecovered:
//                                                   snapshot.data![index]
//                                                       ['todayRecovered'],
//                                               test: snapshot.data![index]
//                                                   ['tests'],
//                                             ),
//                                           ));
//                                     },
//                                     child: ListTile(
//                                       title: Text(
//                                           snapshot.data![index]['country']),
//                                       subtitle: Text(
//                                           'Cases ${snapshot.data![index]['cases'].toString()}'),
//                                       leading: Image(
//                                           height: 50,
//                                           width: 70,
//                                           image: NetworkImage(
//                                               snapshot.data![index]
//                                                   ['countryInfo']['flag'])),
//                                     ),
//                                   )
//                                 ],
//                               );
//                             } else if (name.toLowerCase().contains(
//                                 searchController.text.toLowerCase())) {
//                               return Column(
//                                 children: [
//                                   InkWell(
//                                     onTap: () {
//                                       Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                             builder: (context) =>
//                                                 CountryDetails(
//                                                   image: snapshot.data![index]
//                                                   ['countryInfo']['flag'],
//                                                   name: snapshot.data![index]
//                                                   ['country'],
//                                                   totalCases: snapshot.data![index]
//                                                   ['cases'],
//                                                   totalDeaths: snapshot.data![index]
//                                                   ['deaths'],
//                                                   totalRecovered: snapshot
//                                                       .data![index]['recovered'],
//                                                   active: snapshot.data![index]
//                                                   ['active'],
//                                                   critical: snapshot.data![index]
//                                                   ['critical'],
//                                                   todayRecovered:
//                                                   snapshot.data![index]
//                                                   ['todayRecovered'],
//                                                   test: snapshot.data![index]
//                                                   ['tests'],
//                                                 ),
//                                           ));
//                                     },
//                                     child: ListTile(
//                                       title:
//                                           Text(snapshot.data![index]['country']),
//                                       subtitle: Text(
//                                           'Cases ${snapshot.data![index]['cases'].toString()}'),
//                                       leading: Image(
//                                           height: 50,
//                                           width: 70,
//                                           image: NetworkImage(
//                                               snapshot.data![index]['countryInfo']
//                                                   ['flag'])),
//                                     ),
//                                   )
//                                 ],
//                               );
//                             } else {
//                               Container();
//                             }
//                             return null;
//                           });
//                     }
//                   }))
//         ],
//       ),
//     );
//   }
// }

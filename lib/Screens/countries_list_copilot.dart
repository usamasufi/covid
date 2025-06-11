import 'package:covid/Screens/country_details.dart';
import 'package:covid/Services/states_services.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({super.key});

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextFormField(
              controller: searchController,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                  hintText: 'Search with task',
                  suffixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50))),
            ),
          ),
          Expanded(
              child: FutureBuilder<List<dynamic>>(
                  future: statesServices.countriesListApi(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return ListView.builder(
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return Shimmer.fromColors(
                              baseColor: Colors.grey.shade600,
                              highlightColor: Colors.grey.shade100,
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Container(
                                      height: 10,
                                      width: 80,
                                      color: Colors.white,
                                    ),
                                    subtitle: Container(
                                      height: 10,
                                      width: 80,
                                      color: Colors.white,
                                    ),
                                    leading: Container(
                                      height: 50,
                                      width: 70,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            );
                          });
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No data available'));
                    } else {
                      var filteredList = snapshot.data!.where((country) {
                        String name = country['country'];
                        return name.toLowerCase().contains(
                            searchController.text.toLowerCase());
                      }).toList();

                      if (filteredList.isEmpty) {
                        return const Center(child: Text('No results found'));
                      }

                      return ListView.builder(
                          itemCount: filteredList.length,
                          itemBuilder: (context, index) {
                            var country = filteredList[index];
                            return Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => CountryDetails(
                                            image: country['countryInfo']['flag'],
                                            name: country['country'],
                                            totalCases: country['cases'],
                                            totalDeaths: country['deaths'],
                                            totalRecovered: country['recovered'],
                                            active: country['active'],
                                            critical: country['critical'],
                                            todayRecovered: country['todayRecovered'],
                                            test: country['tests'],
                                          ),
                                        ));
                                  },
                                  child: ListTile(
                                    title: Text(country['country']),
                                    subtitle: Text('Cases ${country['cases']}'),
                                    leading: Image(
                                        height: 50,
                                        width: 70,
                                        image: NetworkImage(
                                            country['countryInfo']['flag'])),
                                  ),
                                )
                              ],
                            );
                          });
                    }
                  }))
        ],
      ),
    );
  }
}

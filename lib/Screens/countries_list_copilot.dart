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
        surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                keyboardType: TextInputType.text,
                style: const TextStyle(color: Colors.white),
                controller: searchController,
                onChanged: (value) {
                  setState(() {});
                },
                cursorColor: Colors.white,
                cursorRadius: const Radius.circular(12),
                autofocus: false,
                decoration: InputDecoration(
                    focusColor: Colors.white,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 20.0),
                    hintText: 'Search with country',
                    hintStyle: const TextStyle(color: Colors.grey),
                    suffixIcon: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    enabled: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
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
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
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
                          return name
                              .toLowerCase()
                              .contains(searchController.text.toLowerCase());
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
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return CountryDetails(
                                          image: country['countryInfo']['flag'],
                                          name: country['country'],
                                          totalCases: country['cases'],
                                          totalDeaths: country['deaths'],
                                          totalRecovered: country['recovered'],
                                          active: country['active'],
                                          critical: country['critical'],
                                          todayRecovered:
                                              country['todayRecovered'],
                                          test: country['tests'],
                                        );
                                      }));
                                      searchController.clear();
                                    },
                                    child: ListTile(
                                      title: Text(country['country']),
                                      subtitle:
                                          Text('Cases ${country['cases']}'),
                                      leading: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image(
                                            height: 50,
                                            width: 70,
                                            image: NetworkImage(
                                                country['countryInfo']
                                                    ['flag'])),
                                      ),
                                    ),
                                  )
                                ],
                              );
                            });
                      }
                    }))
          ],
        ),
      ),
    );
  }
}

// We define APIs used in the app


class AppUrl{
  // this is our base url
  static const String baseUrl = 'https://disease.sh/v3/covid-19/';
  //fetch world covid states
static const String worldStateApi = '${baseUrl}all';
static const String countriesList = '${baseUrl}countries';
}
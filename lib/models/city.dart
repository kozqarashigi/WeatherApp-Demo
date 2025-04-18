class City {
  final String city;
  bool isSelected;
  bool isDefault;

  City({
    required this.city,
    this.isSelected = false,
    this.isDefault = false,
  });

  static List<City> citiesList = [
    City(city: 'Nur-Sultan', isDefault: true),
    City(city: 'Almaty'),
    City(city: 'Shymkent'),
    City(city: 'Aktobe'),
    City(city: 'Karaganda'),
    City(city: 'Taraz'),
    City(city: 'Pavlodar'),
    City(city: 'Semey'),
    City(city: 'Atyrau'),
    City(city: 'Kostanay'),
    City(city: 'Kyzylorda'),
    City(city: 'Uralsk'),
    City(city: 'Petropavl'),
    City(city: 'Aktau'),
    City(city: 'Temirtau'),
  ];

  static List<City> getSelectedCities() {
    return citiesList.where((city) => city.isSelected).toList();
  }

  static City getDefaultCity() {
    return citiesList.firstWhere((city) => city.isDefault);
  }
}
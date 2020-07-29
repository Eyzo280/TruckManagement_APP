enum SelectedAdvertisement {
  Active,
  Finished,
}

class Advertisement {
  final String companyUid; // uid firmy do ktorej nalezy ogloszenie
  final String title;
  final Map<String, bool> requirements; // mapa z wymaganiami np. {'Karta kierowcy': true}
  final String description;
  final String type; // typ ogloszenia np. 'Trucker'

  Advertisement({
    this.companyUid,
    this.title,
    this.requirements,
    this.description,
    this.type,
  });
}

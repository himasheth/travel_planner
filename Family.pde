class Family {
  String name;
  ArrayList<Traveller> fam;
  Trip currentTrip;
  ArrayList <String> family = new ArrayList<String>();
  ArrayList<String> favourites = new ArrayList<String>();


  Family(String n) {
    this.name = n;
    this.fam = new ArrayList<Traveller>();
    this.family = new ArrayList<String>();
    this.favourites = new ArrayList<String>();
  }

//adds travellers to the family
  void addToFamily(Traveller t) {
    fam.add(t);
    family.add(t.name);
    println("The current members in this family are", family);
  }

//prints each family members favourite trips
  void familyFavourites() {
    for (int i = 0; i<this.fam.size(); i++) {
      if (this.fam.get(i).favTrip != null && this.fam.get(i).favTrip.endCountry.canAfford)
        this.favourites.add(this.fam.get(i).favTrip.endCountry.name);
      else
        this.favourites.add(null);
    }   
    for (int i = 0; i<this.favourites.size(); i++) {
      if (this.fam.get(i).favTrip != null) {
        println(this.fam.get(i).name, "has a favourite trip of", this.fam.get(i).favTrip.endCountry.name);
      } else 
      println(this.fam.get(i).name, "has no favourite trip so far.");
    }
  }
}

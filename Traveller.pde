class Traveller {
  String name;
  int age;
  ArrayList<Trip> trips;
  Trip favTrip;

  Traveller(String n, int a) {
    this.name = n;
    this.age = a;
    this.trips = new ArrayList<Trip>();
    this.favTrip = null;
  }

  void addTrip(Trip t) {
    if (t.endCountry.canAfford && t.endCountry.travel.mode !=null)
      this.trips.add(t);
  }

//a quick way of knowing whether or not you took the trip
  boolean tookTrip(Trip t) {
    boolean a = false;
    for (int i = 0; i<trips.size(); i++) {
      if (t == trips.get(i)) 
        a = true;
    }
    return a;
  }

//allows you detemrine the travellers favourite trip
  void chooseFavTrip(Trip favTr) {
    if (favTr.endCountry.canAfford && tookTrip(favTr)) {
      this.favTrip = favTr;
      println(this.name, "claims their favourite trip is", this.favTrip.to);
      favTr.numFav += 1;
    } else 
    println(favTr.to, "is a trip that has not been taken yet.");
  }

//prints the travel plans for the traveller
  void printTravelPlans() {
    for (int i = 0; i < this.trips.size(); i ++) {
      this.trips.get(i).printItinerary();
      if (trips.size() > 1 && (i+1) != trips.size())
        println("N E X T   T R I P");
    }
  }
}

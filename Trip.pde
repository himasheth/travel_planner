class Trip {
  String from; //enter in form (Country, Continent)
  String to;
  String season;
  int dayLong;
  Destination newDest;
  Destination startCountry;
  Destination endCountry;
  ArrayList<Destination> itinerary;
  ArrayList <String> itineraryOfPlaces;
  ArrayList<Integer> itineraryOfDays;
  int currentDay;
  String[] start;
  String[] end;
  int numFav;

  Trip(Destination s, Destination e, String se) {
    this.startCountry = s;
    this.endCountry = e;
    this.from = s.name;
    this.to = e.name;
    this.season = se;
    //this.travel = t;
    this.dayLong = 0; //you add to this as you add destinations
    this.itinerary = new ArrayList<Destination>();
    this.itineraryOfPlaces = new ArrayList<String>();
    this.itineraryOfDays = new ArrayList<Integer>();
    this.currentDay = 0;
    start = this.from.split(",");
    end = this.to.split(",");
  }

  void updateDay() {
    if (this.itinerary.get(this.currentDay).tired == true) {
      this.currentDay += 1;
      //println("Day", this.currentDay);
    }
  }

  void addToItinerary(Destination newDest) {
    if (newDest.travel.mode != null && endCountry.canAfford) {
      this.itineraryOfPlaces.add(newDest.name);
      this.itineraryOfDays.add(newDest.days);
      this.itinerary.add(newDest);
      this.dayLong += newDest.days;
      updateDay();
    } else if (newDest.travel.mode == null) {
      println(newDest.name, "can not be added as you have no way of getting there");
    } else
      println(newDest.name, "can not be added as you can't afford it");
  }


  void printItinerary() {
    int flightNum = int(random(500, 10000));
    println();
    println("Flight #1:");
    println(this.from, "to", this.to);
    println("Flight Info:", this.endCountry.travel.duration, "hour flight on Air", start[0]);
    println("Flight Number:", flightNum);

    println();
    println("Your itinerary:");
    println("-------------------------------------------------------------------------");
    println("City: \t Number of Days: ");

    for (int i=0; i<this.itinerary.size(); i++) {
      println(this.itineraryOfPlaces.get(i), "\t", this.itineraryOfDays.get(i));

      if (this.itinerary.get(i).placesToVisit.size() != 0) {
        println();
        println("\t Excursions: \t Number of Hours: ");
        println("\t *************************************************************************");

        for (int j=0; j<this.itinerary.get(i).placesToVisit.size(); j++) {
          println("\t", this.itinerary.get(i).placesToVisit.get(j)[0], "\t", this.itinerary.get(i).placesToVisit.get(j)[1]);
        }
        println();
        println("-------------------------------------------------------------------------");
      }
    }
    println("Length of Trip:", this.dayLong, "days total.");
  }
}

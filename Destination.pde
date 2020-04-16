class Destination {
  Travel travel;
  String name;
  int days; 
  int tripDay;
  boolean goodWeather;
  boolean tired;
  ArrayList <String[]> placesToVisit;
  int hoursTravelling;
  int today;
  boolean canAfford;


  Destination(String n, int d) {
    this.name = n;
    this.days = d;
    this.placesToVisit = new ArrayList <String[]>();
    this.hoursTravelling = 0;
    this.tired = false;
    this.today = 1;
  }

//uses a random probability to determine if there's going to be good weather at the time that you go to this location
  void willRain() {
    float chance = random(0, 10);
    if (chance <= 2) {
      goodWeather = false;
      println("The weather is going to be bad if you go to", this.name, "at this time.");
    } else {
      goodWeather = true;
      println(this.name, "will be sunny when youare going!");
    }
  }

//this adds Tourist attractionst that you visit at the destinations
  void addTouristAttraction (String place, int h) {
    this.hoursTravelling += h;
    String[] attraction = {place, str(h)};
    if (this.hoursTravelling >= 9) {
      this.tired = true;
      this.today += 1;
      if (this.today < this.days)
        this.hoursTravelling = 0;
    }
    if (!this.tired)
      this.placesToVisit.add(attraction);

    else if (this.tired) {
      if (this.today > this.days) {
        println("You're going to have to extend the time you spend here... until then, we have adjusted the time you have scheduled for", attraction[0]);
        attraction[1] = str(10-this.hoursTravelling);

        if (int(attraction[1]) <= 0)
          println (attraction[0], "wasn't added as you have no more time in", this.name);
        else
          this.placesToVisit.add(attraction);
      } else {
        String[] blank = {" ", " "};
        String[] nextDay = {"~~~~~~~~~~~~~~~~        Go To", "Next Day           ~~~~~~~~~~~~~~~~~~"};
        String[] updateDay = {"Day", str(today)};
        this.placesToVisit.add(blank);
        this.placesToVisit.add(nextDay);
        this.placesToVisit.add(blank);
        this.placesToVisit.add(updateDay);
        this.placesToVisit.add(blank);
        this.placesToVisit.add(attraction);
        this.tired = false;
      }
    }
  }

  void travelTo(Destination from, int duration, int budget) {
    this.travel = new Travel (duration, from, this, budget);
  }
}

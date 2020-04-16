class Travel {
  String mode;
  int duration;
  float cost;
  boolean train;
  Destination start; //enter Destination in form 
  Destination end;
  int budget;
  boolean initial;

  Travel(int d, Destination s, Destination e, int b) {
    // Note: the duration is measured in hours driving and the mode of transportation is determined by that number
    this.duration = d;
    this.start = s;
    this.end = e;
    this.initial = false;
    this.budget = b;
    determineMode();
  }

//uses a random probabilty to determine if there's a train or not
  void isTrain() {
    float chance = random(0, 10);
    if (this.start.days != 0) {
      if (chance <= 3) {
        this.train = false;
        println("There is not a train available to", this.end.name + ".");
      } else if (chance > 3) {
        this.train = true;
        println("There is a train available to", this.end.name + ".");
      }
    } else {
      this.train = false;
      this.initial = true;
    }
  }

//uses the duration of the trip to determine the mode of transportation for the trip
  void determineMode() {
    isTrain();
    if (this.duration >= 6) {
      boolean b = this.planeTicketPrice();
      if (b) {
        this.mode = "air";
        if (this.initial)
          this.end.canAfford = true;
      } else {
        this.mode = null;
        println("The tickets to go to", this.end.name, "are too expensive right now... try another time!");
        if (this.initial)
          this.end.canAfford = false;
      }
    } else if ((0 <= this.duration || this.duration < 6)&& !this.train ) {
      this.mode = "car";
      this.end.canAfford = true;
    } else if ((0 < this.duration || this.duration <= 6)&& this.train ) {
      this.mode = "train";
      this.end.canAfford = true;
    } else {
      this.mode = "walk";
      this.end.canAfford = true;
      println("You might be able to walk or take a taxi!");
    }
  }

  float roundAny(float x, int d) {  
    float y = x * pow(10, d);  
    float z = round(y);  
    return z/pow(10, d);
  }

//uses random probability to determine if you can afford the plane ticket or not
  boolean planeTicketPrice() {
    if (this.duration <= 10) {
      float rand = random(0, this.budget*(5/3));
      rand = roundAny(rand, 2);
      if (rand < this.budget) {
        println("Tickets for a flight from", this.start.name, "to", this.end.name, "are", rand, "dollars! They are in your budget.");
        this.cost = rand;
        return true;
      } else
        return false;
    } else if (this.duration > 10) {
      float rand = random (0, this.budget*(7/3));
      rand = roundAny(rand, 2);
      if (rand < this.budget) {
        println("Tickets for a flight from", this.start.name, "to", this.end.name, "are", rand, "dollars! They are in your budget.");
        this.cost = rand;
        return true;
      } else return false;
    } else {
      return false;
    }
  }

  void printTravelInfo() {
    println();
    println("Travel info for: ", this.end.name);
    println("-------------------------------------------------------------------------");
    if (this.start.days == 0 && this.end.canAfford) {
      println("This is a travel day! You embark on your trip to", this.end.name, "starting today!");
    } else if (this.start.days != 0 && this.end.canAfford) {
      println("You would travel to", this.end.name, "by", this.end.travel.mode);
    } else
      println("You are not going anywhere as of now.");
    println();
  }
}

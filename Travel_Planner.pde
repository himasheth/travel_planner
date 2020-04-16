//imports needed to create the maps
import de.fhpotsdam.unfolding.*;
import de.fhpotsdam.unfolding.core.*;
import de.fhpotsdam.unfolding.data.*;
import de.fhpotsdam.unfolding.events.*;
import de.fhpotsdam.unfolding.geo.*;
import de.fhpotsdam.unfolding.interactions.*;
import de.fhpotsdam.unfolding.mapdisplay.*;
import de.fhpotsdam.unfolding.mapdisplay.shaders.*;
import de.fhpotsdam.unfolding.marker.SimplePointMarker;
import de.fhpotsdam.unfolding.marker.*;
import de.fhpotsdam.unfolding.providers.*;
import de.fhpotsdam.unfolding.texture.*;
import de.fhpotsdam.unfolding.tiles.*;
import de.fhpotsdam.unfolding.ui.*;
import de.fhpotsdam.unfolding.utils.*;
import de.fhpotsdam.utils.*;

//import that allows the you to make HTTP requests easily
import http.requests.*;

UnfoldingMap franceTripMap;

//creating all the arrays that will be used later in the program when it comes to creating the map
ArrayList<String> placeName = new ArrayList<String>();
ArrayList<String> addresses = new ArrayList <String>();
ArrayList<GetRequest> requests = new ArrayList<GetRequest>();
ArrayList<Location> locationToMap = new ArrayList<Location>();
ArrayList<SimplePointMarker> markerArray = new ArrayList<SimplePointMarker>();
String nameMap;

//a function that is called when you want to add something to the map
//Note: currently the only thing working is the mapping of the first item that you add to the map. 
//If you want to see something cool, scroll down to the comment where I say "MapCode" and add a location of your choice to the map as a String."
void addToMap(String d) {
  //println("Add to Map");
  placeName.add(d);
  String[] nameArray = d.split(" ");
  //printArray(nameArray);
  
  //this part of the function turns the place you want on the map into the form of a URL link
  String addressString = "";
  for (int i = 0; i < nameArray.length; i++) {
    addressString += nameArray[i];
    if (nameArray.length != i+1)
      addressString += "+";
  }
  addresses.add(addressString);
}

//this function takes the URL links of the places that you want mapped and creates HTTP requests to the Google Geocoding API to allow me to get the latitude and longitude of the place
void addRequests() {
  //println("Get Requests");
  //println(addresses.size());
  for (int i = 0; i < addresses.size(); i++) {
    //println(addresses.get(i));
    String link = "";
    String link1 = "https://maps.googleapis.com/maps/api/geocode/json?address=";
    String link2 = addresses.get(i);
    String link3 = "&key=AIzaSyA2MYUfwXkH6E88_aQ0Eg8sba6V23_1Fdc";
    link = link1 + link2 + link3;
    //println(link);
    GetRequest get = new GetRequest(link);
    requests.add(get);
  }
}

float roundAny(float x, int d) {  
  float y = x * pow(10, d);  
  float z = round(y);  
  return z/pow(10, d);
}

//this takes the data and uses it to separate the latitude and longitude
void getLatLong() {
  //println("Get LatLong");
  //println(requests.size());
  for (int i = 0; i < requests.size(); i++) {
    GetRequest currentAddress;
    currentAddress = requests.get(i);
    currentAddress.send();
    JSONObject response = parseJSONObject(currentAddress.getContent());
    JSONArray results = response.getJSONArray("results");
    //println(response.get("geometry"));
    JSONObject location = results.getJSONObject(0).getJSONObject("geometry").getJSONObject("location");
    float lat = roundAny(float((location.get("lat").toString())), 2);
    float lng = roundAny(float(location.get("lng").toString()), 2);
    
    //creates a location object that is then used to map the location 
    Location loc = new Location (lat, lng);
    locationToMap.add(loc);
  }
}

//this function creates the final setup required for the map
void createMapSetup(UnfoldingMap map) {
  addRequests();
  getLatLong();
  for (int i = 0; i < locationToMap.size(); i++) {
    //println(locationToMap.get(i));
    SimplePointMarker a = new SimplePointMarker(locationToMap.get(i));
    //println(this.placeName.get(i));
    //println("Location", i, locationToMap.get(i));
    markerArray.add(a);
  }
  
  //TRY CHANGING THE INTEGER TO ZOOM IN AND OUT --------------------------------------------------------------------------------------------------------------------
  map.zoomAndPanTo(locationToMap.get(0), 5);
}

public void setup () {
  //Class Code
  Destination startCountry = new Destination("Canada, North America", 0);
  Destination endCountry = new Destination("France, Europe", 0);
  Trip marchBreak = new Trip(startCountry, endCountry, "Spring");
  endCountry.travelTo(startCountry, 10, 5000);
  //endCountry.travel.printTravelInfo();

  Destination paris = new Destination("Paris", 2);
  Destination nice = new Destination("Nice", 1);
  paris.travelTo(marchBreak.endCountry, 4, 5000);
  nice.travelTo(paris, 4, 1000);

  paris.addTouristAttraction("Eiffel Tower", 3);
  paris.addTouristAttraction("Louvre Museum", 2);
  paris.addTouristAttraction("Lunch at French Restaurant", 2);
  paris.addTouristAttraction("Light Show", 2);
  paris.addTouristAttraction("Arc de Triomphe", 4);

  nice.addTouristAttraction("The Beach", 6);
  nice.addTouristAttraction("Lunch Time", 1);

  marchBreak.addToItinerary(paris);
  marchBreak.addToItinerary(nice);


//  addToMap(endCountry.name);
//  addToMap(paris.name);
//  addToMap("Eiffel Tower");
//  addToMap("Louvre Museum");

  Traveller hima = new Traveller("Hima Sheth", 17);
  Traveller nima = new Traveller ("Nima Sheth", 15);
  Family sheth = new Family ("Sheth Family");

  sheth.addToFamily(hima);
  sheth.addToFamily(nima);
  hima.addTrip(marchBreak);

  Destination alpsStart = new Destination("Canada, North America", 0);
  Destination alpsEnd = new Destination("Switzerland, Europe", 0);
  Trip alpsSki = new Trip (alpsStart, alpsEnd, "Winter");
  alpsEnd.travelTo(alpsStart, 8, 2000);

  Destination geneva = new Destination("Geneva, Switzerland", 3);
  geneva.travelTo(alpsEnd, 7, 1000);
  alpsSki.addToItinerary(geneva);
  geneva.addTouristAttraction("The Mountains", 3);

  hima.addTrip(alpsSki);
  nima.addTrip(marchBreak);
  hima.printTravelPlans();
  hima.chooseFavTrip(alpsSki);
  nima.chooseFavTrip(marchBreak);

  sheth.familyFavourites();

  //Mapping code
  
  //TRY CHANGING THIS BY MAKING THE INPUT A LOCATION IN STRING FORM -- I.E. "eiffel tower" or "650 LaurelWood Drive" --------------------------------------------------------------------------------------------------------------------
  
  addToMap("650 Laurelwood Drive");
  size(800, 800);
  franceTripMap = new UnfoldingMap (this);
  MapUtils.createDefaultEventDispatcher(this, franceTripMap);
  createMapSetup(franceTripMap);
  //SimplePointMarker test = new SimplePointMarker (locationToMap.get(0));
  //franceTripMap.addMarker(test);
}


void draw() {
  franceTripMap.draw();
  Location location = franceTripMap.getLocation(mouseX, mouseY);
  fill(0);
  text(location.getLat() + ", " + location.getLon(), mouseX, mouseY);
}

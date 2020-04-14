import de.fhpotsdam.unfolding.*;
import de.fhpotsdam.unfolding.core.*;
import de.fhpotsdam.unfolding.data.*;
import de.fhpotsdam.unfolding.events.*;
import de.fhpotsdam.unfolding.geo.*;
import de.fhpotsdam.unfolding.interactions.*;
import de.fhpotsdam.unfolding.mapdisplay.*;
import de.fhpotsdam.unfolding.mapdisplay.shaders.*;
import de.fhpotsdam.unfolding.marker.*;
import de.fhpotsdam.unfolding.providers.*;
import de.fhpotsdam.unfolding.texture.*;
import de.fhpotsdam.unfolding.tiles.*;
import de.fhpotsdam.unfolding.ui.*;
import de.fhpotsdam.unfolding.utils.*;
import de.fhpotsdam.utils.*;

UnfoldingMap map;

void setup () {
  exit();
  //Mapping code
  //size(800, 800);
  //map = new UnfoldingMap (this);
  //MapUtils.createDefaultEventDispatcher(this, map);
  //map.zoomAndPanTo(new Location(20.6f, 79.0f), 5);

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
}

void draw() {
  //map.draw();
  //Location location = map.getLocation(mouseX, mouseY);
  //fill(0);
  //text(location.getLat() + ", " + location.getLon(), mouseX, mouseY);
}

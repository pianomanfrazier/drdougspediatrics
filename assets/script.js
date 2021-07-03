const LAT = 41.754280
const LONG = -111.828950
const LAT_LONG = [LAT, LONG]
var mymap = L.map('mapid', { gestureHandling: true }).setView(LAT_LONG, 13);
var marker = L.marker(LAT_LONG).addTo(mymap);
marker.bindPopup("<b>Dr. Doug's Pediatric Dentistry</b><br>1250 N 211 E, Suite 110<br>Logan, UT 84341").openPopup();

L.tileLayer('https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}', {
    attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors, Imagery © <a href="https://www.mapbox.com/">Mapbox</a>',
    maxZoom: 18,
    id: 'mapbox/streets-v11',
    tileSize: 512,
    zoomOffset: -1,
    accessToken: 'pk.eyJ1IjoicGlhbm9tYW5mcmF6aWVyIiwiYSI6ImNra3VlenJmcTBxNmYzMW15a3hpcjl5dnEifQ.5rc5XjsjHEUAZn5uXVVZkg'
}).addTo(mymap);
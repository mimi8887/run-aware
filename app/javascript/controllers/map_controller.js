import { Controller } from "@hotwired/stimulus";
import mapboxgl from "mapbox-gl"; // Core Mapbox library
import MapboxDirections from "@mapbox/mapbox-gl-directions/dist/mapbox-gl-directions"; // Directions plugin

export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array
  }

  connect() {
    // Set the Mapbox access token
    mapboxgl.accessToken = this.apiKeyValue;

    // Initialize the map
    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v10"
    });

    // Wait for the map to fully load before adding directions
    this.map.on("load", () => {
      this.#addDirectionsBetweenMarkers();
    });
  }

  #addDirectionsBetweenMarkers() {
    // Initialize the Mapbox Directions plugin
    const directions = new MapboxDirections({
      accessToken: mapboxgl.accessToken,
      unit: "metric", // Metric units for distance
      profile: "mapbox/driving" // Use driving profile
    });

    // Add the Directions control to the map
    this.map.addControl(directions, "top-left");

    // Get waypoints from markers
    const waypoints = this.markersValue.map((marker) => [marker.lng, marker.lat]);

    if (waypoints.length >= 2) {
      // Set the origin and destination
      directions.setOrigin(waypoints[0]);
      directions.setDestination(waypoints[waypoints.length - 1]);

      // Add intermediate waypoints (if any)
      waypoints.slice(1, -1).forEach((waypoint, index) => {
        directions.addWaypoint(index, waypoint);
      });
    } else {
      console.error("Not enough waypoints to calculate a route.");
    }
  }
}






// import { Controller } from "@hotwired/stimulus"
// import mapboxgl from 'mapbox-gl' // Don't forget this!


// export default class extends Controller {
//   static values = {
//     apiKey: String,
//     markers: Array
//   }

//   connect() {
//     mapboxgl.accessToken = this.apiKeyValue

//     this.map = new mapboxgl.Map({
//       container: this.element,
//       style: "mapbox://styles/mapbox/streets-v10"
//     })

//     this.#addMarkersToMap()
//     this.#fitMapToMarkers()
//   }

//   #addMarkersToMap() {
//     this.markersValue.forEach((marker) => {
//       new mapboxgl.Marker()
//         .setLngLat([ marker.lng, marker.lat ])
//         .addTo(this.map)
//     })
//   }

//   #fitMapToMarkers() {
//     const bounds = new mapboxgl.LngLatBounds()
//     this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
//     this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
//     }

// }

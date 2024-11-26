import { Controller } from "@hotwired/stimulus"
import mapboxgl from 'mapbox-gl' // Don't forget this!

export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v10"
    })

    this.map.on('load', () => {
      this.#addMarkersToMap()
      this.#fitMapToMarkers()
      this.#fetchRoutes() // Fetch both routes
    })
  }

  #fetchRoutes() {
    const start = [this.markersValue[0].lng, this.markersValue[0].lat];
    const end = [this.markersValue[1].lng, this.markersValue[1].lat];

    const url = `https://api.mapbox.com/directions/v5/mapbox/walking/${start.join(',')};${end.join(',')}?geometries=geojson&alternatives=true&access_token=${this.apiKeyValue}`;

    fetch(url)
      .then(response => response.json())
      .then(data => {
        if (data.routes.length === 0) {
          console.error('No routes found');
          return;
        }

        data.routes.forEach((route, index) => {
          const routeId = `route-${index}`;
          console.log(`Adding route ${routeId} with duration ${route.duration / 60} minutes`);
          this.#addRouteToMap(route.geometry, routeId, index);
        });
      })
      .catch(error => console.error('Error fetching routes:', error));
  }

  #addRouteToMap(routeGeometry, routeId, index) {
    if (this.map.getLayer(routeId)) {
      console.error(`Layer with id ${routeId} already exists`);
      return;
    }

    this.map.addLayer({
      id: routeId,
      type: 'line',
      source: {
        type: 'geojson',
        data: {
          type: 'Feature',
          geometry: routeGeometry,
        },
      },
      layout: {
        'line-join': 'round',
        'line-cap': 'round',
      },
      paint: {
        'line-color': index === 0 ? '#3887be' : '#f34c4c', // Blue for primary, red for alternative
        'line-width': 5,
      },
    });
  }

  #addMarkersToMap() {
    this.markersValue.forEach((marker) => {
      new mapboxgl.Marker()
        .setLngLat([ marker.lng, marker.lat ])
        .addTo(this.map)
    })
  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
  }
}

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
      style: "mapbox://styles/mapbox/streets-v10",
      center: [ 13.406493, 52.517218 ],
      zoom: 11
    })

    const steps = this.markersValue;

    steps.forEach((step, index) => {
      console.log(step.longitude)
      console.log(step.latitude)

      new mapboxgl.Marker()
            .setLngLat([ step.longitude, step.latitude ])
            .addTo(this.map)

      const bounds = new mapboxgl.LngLatBounds()
      this.markersValue.forEach(step => bounds.extend([ step.longitude, step.latitude ]))
      this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })

      const url = `https://api.mapbox.com/directions/v5/mapbox/walking/${step.longitude},${step.latitude};${steps[index+ 1].longitude},${steps[index+1].latitude}?geometries=geojson&access_token=${mapboxgl.accessToken}`;
      fetch(url)
        .then(response => response.json())
        .then(data => {
          const route = data.routes[0].geometry.coordinates;
          console.log(route)
          this.map.on('load', () => {

            this.map.addLayer({
              id: `route-${index}`,
              type: 'line',
              source: {
                'type': 'geojson',
                'data': {
                  'type': 'Feature',
                  'properties': {},
                  'geometry': {
                    'type': 'LineString',
                    'coordinates':
                     route
                    ,
                  },
                }
              },
              layout: {
                'line-join': 'round',
                'line-cap': 'round'
              },
              paint: {
                'line-color': '#4e68f8',
                'line-width': 4
              }
            })
            this.map.fitBounds(bounds, {
              padding: {top: 50, bottom: 50, left: 50, right: 50}, // Optional padding around the route
              maxZoom: 15 // Optional maximum zoom level
          });
          })

        });
    });

  }

  // #addMarkersToMap() {
  //   this.markersValue.forEach((marker) => {
  //     new mapboxgl.Marker()
  //       .setLngLat([ marker.lng, marker.lat ])
  //       .addTo(this.map)
  //   })
  // }

  // #fitMapToMarkers() {
  //   const bounds = new mapboxgl.LngLatBounds()
  //   this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
  //   this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
  //   }

}

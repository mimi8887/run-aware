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
      // center: [-122.68035572839027, 45.52729517240144],
      center: [13.413738, 52.522941],
      zoom: 15
    })

    const start = [13.413738, 52.522941];
    const end = [13.390439, 52.507398];
    const url = `https://api.mapbox.com/directions/v5/mapbox/driving/${start[0]},${start[1]};${end[0]},${end[1]}?geometries=geojson&access_token=${mapboxgl.accessToken}`;

    fetch(url)
      .then(response => response.json())
      .then(data => {
        const route = data.routes[0].geometry.coordinates;
        console.log(route)
        this.map.on('load', () => {

          this.map.addLayer({
            id: 'route',
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
              'line-color': '#888',
              'line-width': 4
            }
          })
        })

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

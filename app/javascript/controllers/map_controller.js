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
      center: [-122.68035572839027, 45.52729517240144],
      zoom: 10
    })
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
              'coordinates': [
                [
                  -122.68035572839027,
                  45.52729517240144
                ],
                [
                  -122.67657260381876,
                  45.527330174436116
                ],
                [
                  -122.67657129671815,
                  45.52666556739695
                ],
                [
                  -122.67085005715236,
                  45.52677044480427
                ],
                [
                  -122.66645605237485,
                  45.52862702776275
                ],
                [
                  -122.66560830926798,
                  45.52866212597536
                ],
                [
                  -122.66532421497476,
                  45.52712020010674
                ],
                [
                  -122.6654770006126,
                  45.52158881104725
                ],
                [
                  -122.66684678096325,
                  45.51749007039993
                ]
              ],
            },
          }
        },
        layout: {
          'line-join': 'round',
          'line-cap': 'round'
        },
        paint: {
          'line-color': '#888',
          'line-width': 8
        }
      })
    })

    this.#addMarkersToMap()
    // this.#fitMapToMarkers()
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

import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="loading-animation"
export default class extends Controller {
  static targets = ["loader"]
  connect() {
    console.log(this.loaderTarget)
  }
  display() {
    console.log("testing")
    this.loaderTarget.classList.remove('d-none');
 }
}



// const loader = document.getElementById('loader');

// function showLoader() {
//   loader.classList.remove('d-none');
// }

// function hideLoader() {
//   loader.classList.add('d-none');
// }

// document.addEventListener('turbo:click', () => {
//   showLoader();
// });

// document.addEventListener('turbo:load', () => {
//   hideLoader();
// });

// async function fetchData(url) {
//   try {
//     showLoader();
//     const response = await fetch(url);
//     const data = await response.json();
//     console.log(data);
//   } catch (error) {
//     console.error('Erro ao buscar dados:', error);
//   } finally {
//     hideLoader();
//   }
// }

import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal"
export default class extends Controller {
  static targets = ["modal"]

  connect() {
    console.log("Hello world");
  }

  display() {
    console.log("DISPLAY");
    this.modalTargets.forEach(modal => {
      modal.classList.remove("d-none");
    })
  }

  hide() {
    console.log("HIDE");
    this.modalTargets.forEach(modal => {
      modal.classList.add("d-none");
    })
  }
}

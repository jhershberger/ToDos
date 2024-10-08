import { Controller } from "@hotwired/stimulus"
import { Modal } from "bootstrap"

export default class extends Controller {
  connect() {
    this.modal = new Modal(this.element)
    this.modal.show()


    this.element.addEventListener('turbo:submit-end', (event) => {
      console.log(event);
      if (event.detail.success) {
	this.modal.hide();
      }
    });
  }

}

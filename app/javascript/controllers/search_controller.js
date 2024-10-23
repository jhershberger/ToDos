import { Controller } from "@hotwired/stimulus"
var duration = 500;
var timeoutId = null;

export default class extends Controller {

  search() { 
    window.clearTimeout(timeoutId);

    timeoutId = window.setTimeout(() => {
      this.element.requestSubmit();
    }, duration);
  }
}

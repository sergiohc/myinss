import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="password-toggle"
export default class extends Controller {
  static targets = ["input"]

  password(e) {
    if (this.inputTarget.type === "password") {
      e.target.classList.remove('bi', 'bi-eye-slash');
      e.target.classList.add('bi', 'bi-eye');
      this.inputTarget.type = "text";
    } else {
      e.target.classList.remove('bi', 'bi-eye');
      e.target.classList.add('bi', 'bi-eye-slash');
      this.inputTarget.type = "password";
    }
  }

}

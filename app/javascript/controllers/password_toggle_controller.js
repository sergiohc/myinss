import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = ["unhide"]
  password(e) {
    console.log("password toggle")
    if (this.input.type === "password") {
      e.target.classList.remove('bi bi-eye-slash');
      e.target.classList.add('bi bi-eye');
      this.input.type = "text";
    } else {
      e.target.classList.remove('bi bi-eye');
      e.target.classList.add('bi bi-eye-slash');
      this.input.type = "password";
    }
  }
}
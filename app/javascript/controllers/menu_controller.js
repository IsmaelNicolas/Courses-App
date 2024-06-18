import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="menu"
export default class extends Controller {
  static targets = ["userDropdown", "navbarUser"];

  connect() {
    alert("Hello, Stimulus!")
  }

  toggleUserMenu() {
    this.userDropdownTarget.classList.toggle("hidden");
  }

  toggleMainMenu() {
    this.navbarUserTarget.classList.toggle("hidden");
  }
}

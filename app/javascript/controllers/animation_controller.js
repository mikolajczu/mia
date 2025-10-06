import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    type: String,
    fadeInDelay: Number
  }

  connect() {
    this.setupInitialState()
  }

  disconnect() {
    if (this.observer) this.observer.disconnect()
  }

  setupInitialState() {
    if (this.typeValue === "fade") {
      this.element.classList.add(
        "opacity-0",
        "translate-y-6",
        "transition-all",
        "duration-700",
        "ease-out"
      )

      this.observer = new IntersectionObserver(
        entries => {
          entries.forEach(entry => {
            if (entry.isIntersecting) {
              this.fadeIn()
            } else {
              this.fadeOut()
            }
          })
        },
        { threshold: 0.2 }
      )

      this.observer.observe(this.element)
    }
  }

  fadeIn() {
    setTimeout(() => {
      this.element.classList.remove("opacity-0", "translate-y-6")
      this.element.classList.add("opacity-100", "translate-y-0")
    }, this.fadeInDelayValue || 100)
  }

  fadeOut() {
    this.element.classList.add("opacity-0", "translate-y-6")
    this.element.classList.remove("opacity-100", "translate-y-0")
  }
}

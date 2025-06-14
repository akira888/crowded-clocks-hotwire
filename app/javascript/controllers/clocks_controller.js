import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="clocks"
export default class extends Controller {
  static values = {
    resetInterval: Boolean,
    msec: Number,
    bigHandDeg: String,
    smallHandDeg: String
  }
  static outlets = ['interval']
  connect() {
    if (this.resetIntervalValue && this.hasIntervalOutlet) {
      this.intervalOutlet.intervalMsecValue = this.msecValue
      this.intervalOutlet.startInterval()
    }
  }

  intervalOutletConnected() {
    if (this.intervalOutlet.intervalMsecValue !== this.msecValue) {
      console.log(this.msecValue)
      this.intervalOutlet.intervalMsecValue = this.msecValue
      this.intervalOutlet.startInterval()
    }
  }
}

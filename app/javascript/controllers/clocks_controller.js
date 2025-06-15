import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="clocks"
export default class extends Controller {
  static values = {
    reset: Boolean,
    adjustInterval: Number,
    bigHandDeg: String,
    smallHandDeg: String
  }
  static outlets = ['interval']

  // Turbo Frames用
  connect() {
    if (!this.hasIntervalOutlet) return;
    this.callInterval()
  }

  // 画面初期表示用
  intervalOutletConnected() {
    this.callInterval()
  }

  callInterval() {
    if (this.resetValue) {
      this.intervalOutlet.adjustInterval(this.adjustIntervalValue)
    } else {
      this.intervalOutlet.startInterval()
    }
  }
}

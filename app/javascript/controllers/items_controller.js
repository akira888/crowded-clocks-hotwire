import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {bigDeg: String, smallDeg: String}

  connect() {
    console.log(this.bigDegValue, this.smallDegValue)
  }
  bigDegValueChanged() {
      console.log(this.bigDegValue)
  }

  smallDegValueChanged() {
    console.log(this.smallDegValue)
  }
}

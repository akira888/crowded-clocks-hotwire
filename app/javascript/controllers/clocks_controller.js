import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="clocks"
export default class extends Controller {
  static values = {
    animateStarter: {type: Number, default: null},
    turboVisit: Boolean
  }
  static outlets = ['interval']
  static targets = ["hand"]

  isTurboVisit() {
    return !!this.turboVisitValue
  }

  // Turbo Frames用
  connect() {
    if (this.isTurboVisit()) {
      this.callInterval()
    }

    this.startHandAnimationTimer()
  }

  // 画面初期表示用
  intervalOutletConnected() {
    this.callInterval()
  }

  startHandAnimationTimer() {
    if (this.animateStarterValue) this.stopHandAnimationTimer()

    this.animateStarterValue = setInterval(() => this.animateHands(), 1000)
  }

  stopHandAnimationTimer() {
    clearInterval(this.animateStarterValue)
    this.animateStarterValue = null
  }

  callInterval() {
    if (this.isTurboVisit()) {
      this.intervalOutlet.startInterval()
    } else {
      this.intervalOutlet.adjustInterval()
    }
  }

  animateHands() {
    const now = new Date()
    const halfMinute = 30
    const staySeconds = 3
    let nowSec = now.getSeconds()
    if (nowSec >= halfMinute) nowSec -= halfMinute
    // 03秒以降または33秒以降ならアニメーション
    if (nowSec >= staySeconds) {
      // 実行開始したらトリガーを止める
      this.stopHandAnimationTimer()

      this.handTargets.forEach(hand => {
        const to = hand.dataset.destinationAngle
        if (!to) return
        // 現在の角度
        const from = hand.style.rotate
        // 残り秒数
        const duration = (halfMinute - nowSec) * 1000 - now.getMilliseconds()

        hand.animate([
          { rotate: from },
          { rotate: to }
        ], {
          duration: duration,
          fill: "forwards"
        })
      })
    }
  }

  disconnect() {
    if (this.animateStarterValue) this.stopHandAnimationTimer()
  }
}

require 'rails_helper'

class DummyAnalogClock
  include AnalogClock

  def initialize(now)
    @now = now
  end

  def next_time
    @now
  end
end

RSpec.describe AnalogClock do
  let(:now) { Time.new(2025, 6, 20, 9, 15, 30) } # 2025年6月20日 9:15:30
  let(:dummy) { DummyAnalogClock.new(now) }

  describe '#analog_angles' do
    it '分針と時針の角度の配列を返す' do
      angles = dummy.analog_angles
      expect(angles).to be_an(Array)
      expect(angles.size).to eq(2)
      expect(angles[0]).to eq(dummy.next_minute_angle)
      expect(angles[1]).to eq(dummy.next_hour_angle)
    end
  end

  describe '#next_minute_angle' do
    it '分針の角度を正しく計算する' do
      # 9:15:30 なので、分針は 15 * 6 + 30 * 0.1 = 90 + 3 = 93° + ベース角度 90° = 183°
      expect(dummy.next_minute_angle).to eq(183.0)
    end

    context '異なる時間の場合' do
      let(:now) { Time.new(2025, 6, 20, 6, 45, 0) } # 2025年6月20日 6:45:00

      it '分針の角度を正しく計算する' do
        # 6:45:00 なので、分針は 45 * 6 + 0 * 0.1 = 270° + ベース角度 90° = 360°
        expect(dummy.next_minute_angle).to eq(360.0)
      end
    end
  end

  describe '#next_hour_angle' do
    it '時針の角度を正しく計算する' do
      # 9:15:30 なので、時針は (9 % 12) * 30 + 15 * 0.5 = 270 + 7.5 = 277.5° + ベース角度 90° = 367.5°
      expect(dummy.next_hour_angle).to eq(367.5)
    end

    context '異なる時間の場合' do
      let(:now) { Time.new(2025, 6, 20, 6, 45, 0) } # 2025年6月20日 6:45:00

      it '時針の角度を正しく計算する' do
        # 6:45:00 なので、時針は (6 % 12) * 30 + 45 * 0.5 = 180 + 22.5 = 202.5° + ベース角度 90° = 292.5°
        expect(dummy.next_hour_angle).to eq(292.5)
      end
    end
  end
end

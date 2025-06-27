require 'rails_helper'

class DummyAnalogClock
  include AnalogClock
  attr_reader :now

  def initialize(now)
    @now = now
  end
end

RSpec.describe AnalogClock do
  let(:now) { Time.new(2025, 6, 20, 9, 15, 30) } # 2025年6月20日 9:15:30
  let(:next_time) { now.advance(minutes: 1) }
  let(:dummy) { DummyAnalogClock.new(now) }

  describe '#current_analog_angles' do
    it '分針と時針の角度の配列を返す' do
      angles = dummy.current_analog_angles
      expect(angles).to be_an(Array)
      expect(angles.size).to eq(2)
      expect(angles[0]).to eq(dummy.minute_angle(now))
      expect(angles[1]).to eq(dummy.hour_angle(now))
    end
  end

  describe '#minute_angle' do
    it '分針の角度を正しく計算する' do
      expect(dummy.minute_angle(next_time)).to eq(99.0)
    end

    context '異なる時間の場合' do
      let(:now) { Time.new(2025, 6, 20, 6, 45, 0) } # 2025年6月20日 6:45:00

      it '分針の角度を正しく計算する' do
        expect(dummy.minute_angle(next_time)).to eq(276.0)
      end
    end
  end

  describe '#hour_angle' do
    it '時針の角度を正しく計算する' do
      expect(dummy.hour_angle(next_time)).to eq(278.0)
    end

    context '異なる時間の場合' do
      let(:now) { Time.new(2025, 6, 20, 6, 45, 0) } # 2025年6月20日 6:45:00

      it '時針の角度を正しく計算する' do
        expect(dummy.hour_angle(next_time)).to eq(203.0)
      end
    end
  end
end

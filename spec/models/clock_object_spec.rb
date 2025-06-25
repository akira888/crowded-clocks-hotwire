require 'rails_helper'

RSpec.describe ClockObject do
  let(:now) { Time.new(2025, 6, 20, 12, 30) } # 2025年6月20日 12:30
  let(:position) { 'x' }
  let(:pattern) { 'pattern' }

  subject(:clock_object) { described_class.new(now, position, pattern) }

  describe '#initialize' do
    it 'インスタンス変数を正しく設定する' do
      expect(clock_object.now).to eq(now)
      expect(clock_object.position).to eq(position)
      expect(clock_object.pattern).to eq(pattern)
    end
  end

  describe '#big_hand_angle' do
    it 'NotImplementedErrorをスローする' do
      expect { clock_object.big_hand_angle }.to raise_error(NotImplementedError)
    end
  end

  describe '#small_hand_angle' do
    it 'NotImplementedErrorをスローする' do
      expect { clock_object.small_hand_angle }.to raise_error(NotImplementedError)
    end
  end

  describe '#next_time' do
    it 'currentTimeから1分進んだ時間を返す' do
      # privateメソッドをテストするためにsendメソッドを使用
      next_time = clock_object.send(:next_time)
      expect(next_time).to eq(now + 60) # 60秒（1分）後
    end
  end
end

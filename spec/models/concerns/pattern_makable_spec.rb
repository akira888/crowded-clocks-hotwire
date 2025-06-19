require 'rails_helper'

class DummyPattern
  include PatternMakable
end

RSpec.describe PatternMakable do
  let(:dummy) { DummyPattern.new }

  describe '#transit_pattern?' do
    context '秒数が5から30の範囲内の場合' do
      it '5秒の場合はtrueを返す' do
        time = Time.new(2025, 6, 20, 12, 30, 5)
        expect(dummy.transit_pattern?(time)).to be true
      end

      it '15秒の場合はtrueを返す' do
        time = Time.new(2025, 6, 20, 12, 30, 15)
        expect(dummy.transit_pattern?(time)).to be true
      end

      it '30秒の場合はtrueを返す' do
        time = Time.new(2025, 6, 20, 12, 30, 30)
        expect(dummy.transit_pattern?(time)).to be true
      end
    end

    context '秒数が5から30の範囲外の場合' do
      it '4秒の場合はfalseを返す' do
        time = Time.new(2025, 6, 20, 12, 30, 4)
        expect(dummy.transit_pattern?(time)).to be false
      end

      it '0秒の場合はfalseを返す' do
        time = Time.new(2025, 6, 20, 12, 30, 0)
        expect(dummy.transit_pattern?(time)).to be false
      end

      it '31秒の場合はfalseを返す' do
        time = Time.new(2025, 6, 20, 12, 30, 31)
        expect(dummy.transit_pattern?(time)).to be false
      end

      it '59秒の場合はfalseを返す' do
        time = Time.new(2025, 6, 20, 12, 30, 59)
        expect(dummy.transit_pattern?(time)).to be false
      end
    end
  end
end

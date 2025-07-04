require 'rails_helper'

RSpec.describe DigitalPartsMap do
  describe '.by_number' do
    context '有効な数値（0-9）が渡された場合' do
      it '0に対応する配列を返す' do
        result = DigitalPartsMap.by_number(0)
        expect(result).to be_an(Array)
        expect(result.size).to eq(15)
        expect(result).to include("down+right", "left+right", "down+left", "down+up", "not_parts", "up+right", "up+left")
      end

      it '1に対応する配列を返す' do
        result = DigitalPartsMap.by_number(1)
        expect(result).to be_an(Array)
        expect(result.size).to eq(15)
        expect(result).to include("down+down", "down+up", "not_parts", "up+up")
      end

      it '5に対応する配列を返す' do
        result = DigitalPartsMap.by_number(5)
        expect(result).to be_an(Array)
        expect(result.size).to eq(15)
        expect(result).to include("down+right", "left+right", "left+left", "up+right", "up+left")
      end
    end

    context '無効な数値が渡された場合' do
      it 'その他の数値には空の配列を返す' do
        expect(DigitalPartsMap.by_number(10)).to eq([])
        expect(DigitalPartsMap.by_number(-1)).to eq([])
        expect(DigitalPartsMap.by_number(nil)).to eq([])
      end
    end
  end
end

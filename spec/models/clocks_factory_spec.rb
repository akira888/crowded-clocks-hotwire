require 'rails_helper'

RSpec.describe ClocksFactory do
  let(:margin) { 2 }
  let(:pattern) { 'default' }
  let(:now) { Time.new(2025, 6, 20, 12, 30, 0) }
  let(:start) { Time.new(2025, 6, 20, 12, 0) } # オプションのスタート時間

  subject(:factory) { described_class.new(margin, pattern, now, start) }

  describe '#initialize' do
    it 'インスタンス変数を正しく設定する' do
      expect(factory.margin).to eq(margin)
      expect(factory.pattern).to eq(pattern)
      expect(factory.start).to eq(start)
    end
  end

  describe '#create' do
    it '時計オブジェクトの配列を返す' do
      clocks = factory.create
      expect(clocks).to be_an(Array)
      expect(clocks).not_to be_empty
      expect(clocks.all? { |clock| clock.is_a?(ClockObject) }).to be true
    end

    it 'デジタル部品と基本部品を適切に作成する' do
      allow(Time).to receive(:now).and_return(Time.new(2025, 6, 20, 12, 30))

      clocks = factory.create

      # デジタル部品と基本部品の両方が含まれることを確認
      digital_parts = clocks.select { |c| c.is_a?(Clock::DigitalPart) }
      basic_parts = clocks.select { |c| c.is_a?(Clock::Basic) }

      expect(digital_parts).not_to be_empty
      expect(basic_parts).not_to be_empty
    end
  end

  describe '#matrix_width' do
    it 'マトリックスの幅を返す' do
      # margin=2の場合、total_width = 2*2 + 3*4 + 3 = 19
      expect(factory.matrix_width).to eq(19)
    end
  end

  describe '#digital_parts?' do
    it 'NON_DIGITAL_PARTSに含まれない文字に対してtrueを返す' do
      expect(factory.send(:digital_parts?, '0')).to be true
      expect(factory.send(:digital_parts?, '1')).to be true
    end

    it 'NON_DIGITAL_PARTSに含まれる文字に対してfalseを返す' do
      expect(factory.send(:digital_parts?, ClocksFactory::NORMAL_PARTS)).to be false
    end
  end

  describe '#digital_part_group' do
    it '有効な位置に対して適切なグループ番号を返す' do
      # マトリックスを作成
      matrix = factory.send(:matrix)

      # margin=2, グループ0の位置(row=2, col=2)をテスト
      expect(factory.send(:digital_part_group, 2, 2)).to eq(0)

      # margin=2, グループ1の位置(row=2, col=6)をテスト
      expect(factory.send(:digital_part_group, 2, 6)).to eq(1)

      # margin=2, グループ2の位置(row=2, col=10)をテスト
      expect(factory.send(:digital_part_group, 2, 10)).to eq(2)

      # margin=2, グループ3の位置(row=2, col=14)をテスト
      expect(factory.send(:digital_part_group, 2, 14)).to eq(3)
    end

    it '無効な位置に対してnilを返す' do
      # マージン部分の位置
      expect(factory.send(:digital_part_group, 0, 0)).to be_nil

      # グループの境界外の位置
      expect(factory.send(:digital_part_group, 2, 18)).to be_nil
    end
  end

  describe '#matrix' do
    it '適切なサイズのマトリックスを生成する' do
      matrix = factory.send(:matrix)

      # margin=2の場合、height = 2*2 + 5 = 9, width = 2*2 + 3*4 + 3 = 19
      expect(matrix.size).to eq(9)
      expect(matrix.first.size).to eq(19)
    end

    it 'デジタル部分に16進数の値を設定する' do
      matrix = factory.send(:matrix)

      # グループ0の最初の要素(position=0)は16進数で'0'
      expect(matrix[2][2]).to eq('0')

      # グループ0の最後の要素(position=14)は16進数で'e'
      expect(matrix[6][4]).to eq('e')
    end
  end
end

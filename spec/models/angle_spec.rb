require 'rails_helper'

RSpec.describe Angle do
  describe '.fixed_angles' do
    context '有効なキーワードが渡された場合' do
      it 'upは90度を返す' do
        expect(Angle.fixed_angles('up')).to eq([ 90 ])
      end

      it 'downは270度を返す' do
        expect(Angle.fixed_angles('down')).to eq([ 270 ])
      end

      it 'leftは0度を返す' do
        expect(Angle.fixed_angles('left')).to eq([ 0 ])
      end

      it 'rightは180度を返す' do
        expect(Angle.fixed_angles('right')).to eq([ 180 ])
      end

      it '複合キーワード "up_right" は [90, 180] を返す' do
        expect(Angle.fixed_angles('up+right')).to eq([ 90, 180 ])
      end

      it '複合キーワード "left_down" は [0, 270] を返す' do
        expect(Angle.fixed_angles('left+down')).to eq([ 0, 270 ])
      end
    end

    context '無効なキーワードが渡された場合' do
      it '未定義のキーワードではnilを返す' do
        expect(Angle.fixed_angles('invalid')).to be_nil
      end

      it '部分的に有効なキーワードでも無効な部分があればnilを返す' do
        expect(Angle.fixed_angles('up_invalid')).to be_nil
      end
    end
  end

  describe '.not_parts?' do
    it '"not_parts"キーワードに対してtrueを返す' do
      expect(Angle.not_parts?('not_parts')).to be true
    end

    it '他のキーワードに対してfalseを返す' do
      expect(Angle.not_parts?('up')).to be false
      expect(Angle.not_parts?('down')).to be false
      expect(Angle.not_parts?('')).to be false
    end
  end
end

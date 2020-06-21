# frozen_string_literal: true

require 'pry'
require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do
  describe '#update_quality' do
    it 'does not change the name' do
      items = [Item.new('First item', 0, 0)]
      updated_item = GildedRose.new(items).update_quality

      expect(updated_item.first.name).to eq 'First item'
    end

    it 'should decrease the quality by one' do
      items = [Item.new('First item', 20, 15)]
      updated_item = GildedRose.new(items).update_quality

      expect(updated_item.first.quality).to eq(14)
      expect(updated_item.first.sell_in).to eq(20)
    end

    it 'should increase two into the quality' do
      items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 10, 35)]
      updated_item = GildedRose.new(items).update_quality

      expect(updated_item.first.quality).to eq(37)
      expect(updated_item.first.sell_in).to eq(10)
    end

    it 'should increase the quality value by 2' do
      items = [Item.new('Aged Brie', 5, 20)]
      updated_item = GildedRose.new(items).update_quality

      expect(updated_item.first.quality).to eq(22)
      expect(updated_item.first.sell_in).to eq(5)
    end

    it 'should decrease the quantity in sell in by one' do
      items = [Item.new('Aged Brie', 2, 100)]
      updated_item = GildedRose.new(items).update_quality

      expect(updated_item.first.quality).to eq(100)
      expect(updated_item.first.sell_in).to eq(1)
    end
  end
end

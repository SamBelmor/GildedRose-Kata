# frozen_string_literal: true

class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      if different_from_brie_and_backstage?(item.name)
        item.quality = first_validation(item)
      elsif quality_less_than_fifty?(item.quality)
        second_validation(item)
      elsif different_from_sulfuras?(item.name)
        item.sell_in = subtract(item.sell_in)
      elsif item.sell_in.negative?
        third_validation(item)
      end
    end
  end

  def different_from_sulfuras?(name)
    name != 'Sulfuras, Hand of Ragnaros'
  end

  def diffent_from_brie?(name)
    name != 'Aged Brie'
  end

  def different_from_brie_and_backstage?(name)
    diffent_from_brie?(name) &&
      name != 'Backstage passes to a TAFKAL80ETC concert'
  end

  def equal_to_brie_and_backstage(name)
    name == 'Backstage passes to a TAFKAL80ETC concert'
  end

  def subtract(item)
    item - 1
  end

  def sum(quality)
    quality + 1
  end

  def quality_less_than_fifty?(quality)
    quality < 50
  end

  def first_validation(item)
    return unless item.quality.positive? && different_from_sulfuras?(item.name)

    subtract(item.quality)
  end

  def second_validation(item)
    item.quality = sum(item.quality)
    item.quality = if equal_to_brie_and_backstage(item.name) && item.sell_in < 11
                     sum(item.quality)
                   elsif item.sell_in < 6
                     sum(item.quality)
                   end
  end

  def third_validation(item)
    if different_from_brie_and_backstage?(item.name)
      first_validation(item)
    elsif diffent_from_brie?(item.name)
      item.quality = item.quality - item.quality
    elsif quality_less_than_fifty?(item.quality)
      sum(item.quality)
    end
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end

# frozen_string_literal: true

class Category < ApplicationRecord
  validates :title, presence: { message: '名称不能为空' }
  validates :title, uniqueness: { message: '名称不能重复' }

  has_ancestry
  has_many :products, dependent: :destroy
  before_validation :correct_ancestry

  private

  def set_default_attr
    self.uuid = RandomCode.generate_product_uuid
  end

  def correct_ancestry
    self.ancestry = nil if ancestry.blank?
  end

  def self.grouped_data
    roots.order('weight desc').inject([]) do |result, parent|
      row = []
      row << parent
      row	<< parent.children.order('weight desc')
      result << row
    end
  end
end

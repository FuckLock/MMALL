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

  class << self
    def grouped_data
      row = []
      roots.order('weight desc').each do |parent|
        row << parent.children.order('weight desc')
      end
      return row
    end
  end
end

class Category < ApplicationRecord
  has_many :ads
  has_many :childs, class_name: "Category", foreign_key: "father_id"
  belongs_to :father, class_name: "Category", optional: true

  def self.enabled_categories
    categories = []
    Category.all.each { |c| categories << c if c.childs.empty?  }
    categories
  end

  def self.fathers
    Category.where(father: nil)
  end
end

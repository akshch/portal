class Question < ApplicationRecord

  has_many :answers
  has_many :taggings, dependent: :delete_all
  has_many :tags, through: :taggings

  has_many :categorizations, dependent: :delete_all
  has_many :categories, through: :categorizations
  
  def self.search(search)
    if search
        where(["title LIKE ?","%#{search}%"])
    else
        all
    end
  end
 
  #setter
  def tag_list=(names)
    self.tags = names.downcase.split(',').map do |n|
      Tag.where(name: n).first_or_create!
    end
  end

  #getter
  def tag_list
    tags.map(&:name).join(', ')
  end

  def category_list=(names)
    #byebug
    self.categories = names.titleize.split(',').map do |n|
      Category.where(name: n).first_or_create!
    end
  end

  def category_list
    categories.map(&:name).join(', ')
  end
end

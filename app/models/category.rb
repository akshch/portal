class Category < ApplicationRecord
  has_many :categorizations
  has_many :questions, through: :categorizations, dependent: :destroy
end

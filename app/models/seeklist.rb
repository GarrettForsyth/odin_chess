class Seeklist < ApplicationRecord
  has_many :seeks, dependent: :destroy
  has_many :users, through: :seeks

  validates :name, presence: true, uniqueness: true
end

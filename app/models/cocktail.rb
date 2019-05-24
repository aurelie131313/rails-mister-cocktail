class Cocktail < ApplicationRecord
  belongs_to :user
  has_many :doses, dependent: :destroy
  has_many :ingredients, through: :doses
  has_many :reviews, dependent: :destroy

  validates :name, uniqueness: true, presence: true
  validates :about, :instructions, :photo, presence: true

  mount_uploader :photo, PhotoUploader

  def self.search(search)
    where("name ILIKE ? OR about ILIKE ? OR instructions ILIKE ?", "%#{search}%", "%#{search}%", "%#{search}%")
  end
end

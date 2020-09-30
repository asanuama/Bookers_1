class Book < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  validates :bo, presence: true
end

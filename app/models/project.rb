class Project < ApplicationRecord
  validates_presence_of :title, :description
  has_many :todos, dependent: :destroy
  accepts_nested_attributes_for :todos

end

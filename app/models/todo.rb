class Todo < ApplicationRecord
  validates_presence_of :title, :description
  belongs_to :project, optional: true

  enum :category, [:goal, :chore, :work, :exercise, :other]


  def category=(value)
    value = value.to_i if value.is_a? String
    super(value)
  end
end

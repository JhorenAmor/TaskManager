class Task < ApplicationRecord
  acts_as_list column: :sort_key

  validates :name, presence: true, uniqueness: true

  def to_s
    name
  end
end

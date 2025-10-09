class Task < ApplicationRecord
  belongs_to :user, optional: true
  has_many :comments, dependent: :destroy

  validates :title, presence: true

  after_initialize :set_default_completed, if: :new_record?

  private

  def set_default_completed
    self.completed ||= false
  end
end

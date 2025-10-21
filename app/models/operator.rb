class Operator < ApplicationRecord
  belongs_to :task
  validates :name, presence: true

  before_save :set_default_role

  private

  def set_default_role
    self.role = "Unassigned" if role.blank?
  end
end

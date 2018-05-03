class Seek < ApplicationRecord
  belongs_to :user
  belongs_to :seeklist

  validates :timecontrol, numericality: { greater_than: 0 }
  validate :user_confirmed?

  private

  def user_confirmed?
    errors.add(:user, 'must be confirmed.') unless user && user.confirmed?
  end
end

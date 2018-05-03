class User < ApplicationRecord
  has_many :seeks
  has_many :seeklists, through: :seeks

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         :confirmable

  # Virtual attribute for authenticating by either handle or email
  # This is in addition to a real persisted field like 'handle'
  attr_accessor :login

  VALID_HANDLE_REGEX = /\A[a-zA-Z0-9\-_]+\z/ # Only letters letters and numbers
  validates :handle, presence: true,
                     length: { maximum: 20 },
                     format: { with: VALID_HANDLE_REGEX },
                     uniqueness: { case_sensitive: false }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, length: { maximum: 256 }, format: { with: VALID_EMAIL_REGEX }

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(['lower(handle) = :value OR lower(email) = :value', { value: login.downcase }]).first
    elsif conditions.key?(:handle) || conditions.key?(:email)
      conditions[:email].downcase! if conditions[:email] 
      where(conditions.to_h).first
    end
end
end

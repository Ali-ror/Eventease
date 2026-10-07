class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum :role, { host: 0, vendor: 1, admin: 2 }, validate: true

  validates :name, presence: true

  before_validation :set_default_role, on: :create

  def first_name
    name.to_s.split.first.presence || email.to_s.split("@").first
  end

  private

  def set_default_role
    self.role = :host if role.blank?
  end
end

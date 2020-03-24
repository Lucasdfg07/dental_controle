class User < ApplicationRecord
  has_many :patients

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: [:user, :admin]

  enum plan: [:basic, :intermediate, :advanced]

  enum payment_status: [:pendent, :canceled, :test_period]

  validates_presence_of :payment_expiration, :payment_status, :plan, :role
end

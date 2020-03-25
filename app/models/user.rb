class User < ApplicationRecord
  has_many :patients

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: [:user, :admin]

  enum plan: [:Básico, :Intermediário, :Avançado]

  enum payment_status: [:Pendente, :Cancelado, :Teste]

  mount_uploader :avatar, AvatarUploader

  validates_presence_of :payment_expiration, :payment_status, :plan, :role
end

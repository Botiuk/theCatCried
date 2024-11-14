# frozen_string_literal: true

class User < ApplicationRecord
  has_many :categories, dependent: :destroy
  has_many :operations, dependent: :destroy

  validates :email, uniqueness: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
end

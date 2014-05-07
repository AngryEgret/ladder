class Player < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  if Rails.env.development? || Rails.env.test?
    devise :database_authenticatable
  else
    devise :omniauthable, :omniauth_providers => [:twitter]
  end

  devise :registerable, :recoverable, :rememberable, :trackable, :validatable


  has_and_belongs_to_many :games
  has_many :matches
end

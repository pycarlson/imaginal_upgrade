class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :videos, :dependent => :destroy
  has_one :profile, :dependent => :destroy

  after_create  :build_profile

  private

  def build_profile
    user = User.find(User.last.id)
    user.profile = Profile.create(full_name: user.full_name)
    user.save
  end
end

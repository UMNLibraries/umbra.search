class User < ActiveRecord::Base
  mount_uploader :avatar, AvatarUploader
  after_update :crop_avatar
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h

  include Blacklight::Folders::User
# Connects this user object to Blacklights Bookmarks. 
  include Blacklight::User
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # validates_presence_of   :avatar
  validates_integrity_of  :avatar
  validates_processing_of :avatar

  # Method added by Blacklight; Blacklight uses #to_s on your
  # user class to get a user-displayable login/identifier for
  # the account.
  def to_s
    email
  end

  def crop_avatar
    avatar.recreate_versions! if crop_x.present?
  end
end
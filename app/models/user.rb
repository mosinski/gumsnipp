class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:github]
  has_many :snipss

  validates :nickname, presence: true, :uniqueness => {:case_sensitive => false}
  validates_format_of :nickname, :with => /\A\w*\z/

  def avatar(size)
    if self.avatar_url.present?
      self.avatar_url
    else
      gravatar_id = Digest::MD5.hexdigest(self.email.downcase)
      "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}"
    end
  end

  def snipps
    Snipp.where(user_id: self.id)
  end

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.nickname = auth.info.name
      user.avatar_url = auth.info.image
    end
  end
end

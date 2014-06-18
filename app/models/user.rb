class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
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
end

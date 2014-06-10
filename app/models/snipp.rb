class Snipp < ActiveRecord::Base
  belongs_to :user

  def slug
    title.downcase.gsub(" ", "-")
  end

  def to_param
    "#{id}-#{slug}"
  end
end

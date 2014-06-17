class Snipp < ActiveRecord::Base
  belongs_to :user
  has_one :visit, :as => :visitable
  acts_as_taggable
  acts_as_taggable_on :tags

  validates :title, presence: true
  validates :title, uniqueness: true
  validates :html_code, presence: true
  validate :maximum_amount_of_tags

  def maximum_amount_of_tags
    number_of_tags = tag_list_cache_on("tags").uniq.length
    errors.add(:base, "Please only add 3 tags") if number_of_tags > 3
  end

  def slug
    title.downcase.gsub(" ", "-")
  end

  def to_param
    "#{id}-#{slug}"
  end

  def visits_count
    visit = Visit.find_by_visitable_id(self.id)
    if visit
      visit.total_visits
    else
      0
    end
  end

  def self.search(search, page)
    order('title').where('title LIKE ?', "%#{search}%").paginate(page: page, per_page: 9)
  end

  def owner?(user)
    self.user_id == user.id
  end
end

class Snipp < ActiveRecord::Base
  belongs_to :user
  has_one :visit, :as => :visitable
  acts_as_taggable
  acts_as_taggable_on :tags

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
end

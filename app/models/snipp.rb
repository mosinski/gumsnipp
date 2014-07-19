class Snipp < ActiveRecord::Base
  belongs_to :user
  has_one :visit, :as => :visitable
  acts_as_taggable
  acts_as_taggable_on :tags

  FRAMEWORK_VERSIONS = FrameworkHelper.get_versions.collect{|a, b| b}

  validates :title, presence: true
  validates :title, uniqueness: true
  validates_format_of :title, :with => /\A[A-Z\sa-z]+\z/
  validates :html_code, presence: true
  validate :maximum_amount_of_tags
  validate :minimum_amount_of_tags
  validates :framework_version, presence: true
  validates_inclusion_of :framework_version, :in => FRAMEWORK_VERSIONS

  def maximum_amount_of_tags
    number_of_tags = tag_list_cache_on("tags").uniq.length
    errors.add(:base, "Please only add 3 tags") if number_of_tags > 3
  end

  def minimum_amount_of_tags
    number_of_tags = tag_list_cache_on("tags").uniq.length
    errors.add(:base, "Please add some tags") if number_of_tags == 0
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
    case Rails.env
    when "production"
      order('created_at DESC').where('title ILIKE ?', "%#{search}%").paginate(page: page, per_page: 9)
    when "development"
      order('created_at DESC').where('title LIKE ?', "%#{search}%").paginate(page: page, per_page: 9)
    when "test"
      order('created_at DESC').where('title LIKE ?', "%#{search}%").paginate(page: page, per_page: 9)
    end
  end

  def owner?(user)
    self.user_id == user.id
  end

  def self.html_tags
    tags = %w(a acronym b strong i em li ul ol h1 h2 h3 h4 h5 h6 hr blockquote br cite sub sup ins p div button textarea input form span select option fieldset legend label img section for table thead tbody tr th td footer script)
  end

  def self.html_attributes
    attributes = %w(href title id class type value name width height scrollbars placeholder src gumby-trigger gumby-retina data-tooltip colspan)
  end
end

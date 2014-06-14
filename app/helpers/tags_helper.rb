module TagsHelper
  def self.get_tags
    ActsAsTaggableOn::Tag.all.group("tags.id").select(:name).order("tags.name ASC")
  end
end

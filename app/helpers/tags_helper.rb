module TagsHelper
  def self.get_tags
    ActsAsTaggableOn::Tag.all.group("tags.id").select(:name, :taggings_count).order("tags.taggings_count DESC")
  end
end

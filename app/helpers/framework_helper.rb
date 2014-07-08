module FrameworkHelper
  def self.get_versions
    [FrameworkVersion.all.collect{|r| "Gumby " + r.version + " + jQuery 1.11.0"}, FrameworkVersion.all.collect{|r| r.version}].transpose.sort
  end
end

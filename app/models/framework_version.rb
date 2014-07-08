class FrameworkVersion < ActiveRecord::Base
  validates :version, presence: true
  validates :version, uniqueness: true
end

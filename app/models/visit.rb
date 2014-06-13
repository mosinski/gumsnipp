class Visit < ActiveRecord::Base
  belongs_to :visitable, :polymorphic => true
  has_many :visit_details

  def self.track(obj, ip_address)
    visit = Visit.find_or_create_by(visitable_id: obj.id, visitable_type: obj.class.name)
    unless VisitDetail.find_by_visit_id_and_ip_address(visit.id, ip_address)
      visit.increment!(:unique_visits)
    end
    visit.increment!(:total_visits)
    visit_detail = visit.visit_details.create(:ip_address => ip_address)
  end
end

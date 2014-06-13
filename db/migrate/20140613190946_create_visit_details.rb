class CreateVisitDetails < ActiveRecord::Migration
  def self.up
    create_table :visit_details do |t|
      t.integer :visit_id
      t.string :ip_address, :limit => 15
      t.timestamps
    end
    add_index :visit_details, :visit_id
    add_index :visit_details, :ip_address
  end

  def self.down
    remove_index :visit_details, :visit_id
    remove_index :visit_details, :ip_address
    drop_table :visit_details
  end
end

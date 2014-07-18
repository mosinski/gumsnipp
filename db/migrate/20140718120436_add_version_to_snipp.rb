class AddVersionToSnipp < ActiveRecord::Migration
  def change
    add_column :snipps, :snipp_version, :integer, default: 1
  end
end

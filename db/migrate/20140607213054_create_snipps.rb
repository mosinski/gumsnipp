class CreateSnipps < ActiveRecord::Migration
  def change
    create_table :snipps do |t|
      t.string :title
      t.text :html_code
      t.text :css_code
      t.text :js_code
      t.integer :user_id
      t.boolean :published,          default: false
      t.boolean :to_check,          default: false

      t.timestamps
    end
  end
end

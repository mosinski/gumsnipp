class CreateFrameworkVersions < ActiveRecord::Migration
  def change
    create_table :framework_versions do |t|
      t.string :version, null: false

      t.timestamps
    end
  end
end

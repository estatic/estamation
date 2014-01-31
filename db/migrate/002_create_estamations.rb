class CreateEstamations < ActiveRecord::Migration
  def change
    create_table :estamations do |t|
      t.string :title, :nullable => false
      t.text :description
      t.references :user
      t.string :link
      t.references :estamation_status, :default => 1
      t.datetime :actual_due
      t.references :issue_priority
      t.references :project
      
      t.timestamps
    end
    add_index :estamations, :user_id
    add_index :estamations, :estamation_status_id
  end
end

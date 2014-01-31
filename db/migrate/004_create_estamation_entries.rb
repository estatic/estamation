class CreateEstamationEntries < ActiveRecord::Migration
  def change
    create_table :estamation_entries do |t|
      t.text :note
      t.boolean :private
      t.float :hours_min
      t.float :hours_max
      t.references :estamation
      t.references :user
      
      t.timestamps
    end
    add_index :estamation_entries, :estamation_id
  end
end

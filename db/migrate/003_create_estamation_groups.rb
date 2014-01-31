class CreateEstamationGroups < ActiveRecord::Migration
  def change
    create_table :estamation_groups do |t|
      t.string :title
    end
  end
end

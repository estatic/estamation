class CreateEstamationStatuses < ActiveRecord::Migration
  def change
    create_table :estamation_statuses do |t|
      t.string :title, :unique => true, :nullable => false
      t.boolean :closed
    end
    EstamationStatus.create([{:title => 'Initial'},{:title => 'In Progress'},{:title => 'Complete'},{:title => 'Won'},{:title => 'Cancelled'}])
    
  end
  
end

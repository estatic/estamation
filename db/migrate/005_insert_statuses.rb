class InsertStatuses < ActiveRecord::Migration
  def change

    EstamationStatus.create([{:title => 'Initial'},{:title => 'In Progress'},{:title => 'Complete'},{:title => 'Won'},{:title => 'Cancelled'}])
    
  end
  
end
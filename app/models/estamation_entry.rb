class EstamationEntry < ActiveRecord::Base
  unloadable
  belongs_to :estamation
  belongs_to :user
  
  acts_as_attachable :after_add => :attachment_added, :after_remove => :attachment_removed
  
  after_create :send_notification
  
  def send_notification
      EstamationMailer.deliver_estamation_entry_add(self)
  end
end

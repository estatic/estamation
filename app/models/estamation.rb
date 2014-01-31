class Estamation < ActiveRecord::Base
  unloadable
  belongs_to :estamation_status
  belongs_to :issue_priority
  belongs_to :project
  belongs_to :user
  has_and_belongs_to_many :estamation_groups
  has_many :estamation_entries
  
  acts_as_attachable :after_add => :attachment_added, :after_remove => :attachment_removed
  acts_as_watchable
  acts_as_searchable :columns => ['title', "#{table_name}.description"],
                     # sort by id so that limited eager loading doesn't break with postgresql
                     :order_column => "#{table_name}.id"
  after_create :send_notification           

    def editable?
        return true if User.current.id == self.user_id
        return true if User.current.admin?
        return false
    end
    
    def entryble?
        return true if self.watcher_users.include? User.current
        return true if User.current.admin?
        return true if self.editable?
        return false
    end
    
    def send_notification
        EstamationMailer.deliver_estamation_add(self)
    end
    
end

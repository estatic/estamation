class EstamationMailer < Mailer
    
    
    def estamation_add(estamation, to_users, cc_users)
      redmine_headers 'Estamation' => estamation.id,
                      'Estamation-Author' => estamation.user.login

      @author = estamation.user
      @estamation = estamation
      @users = to_users + cc_users
      @estamation_url = url_for(:controller => 'estamations', :action => 'show', :id => estamation)
      mail :to => to_users.map(&:mail),
        :cc => cc_users.map(&:mail),
        :subject => "[#{estamation.title} - ##{estamation.id}] (#{estamation.estamation_status})"
    end
    
    def entry_add(entry, to_users, cc_users)
      redmine_headers 'Estamation' => entry.estamation.id,
                      'Estamation-Author' => entry.estamation.user.login

      @author = User.current
      @estamation = entry.estamation
      @entry = entry
      @users = to_users + cc_users
      @estamation_url = url_for(:controller => 'estamations', :action => 'show', :id => entry.estamation)
      mail :to => to_users.map(&:mail),
        :cc => cc_users.map(&:mail),
        :subject => "[#{entry.estamation.title} - ##{entry.estamation.id}] New Entry"
    end

    # Notifies users about a new issue
    def self.deliver_estamation_add(estamation)
      to = [estamation.user]
      cc = estamation.notified_watchers - to
      #estamation.each_notification(to + cc) do |users|
      EstamationMailer.estamation_add(estamation, to, cc).deliver
      #end
    end
    
    def self.deliver_estamation_entry_add(entry)
        to = [entry.estamation.user]
        cc = []
        #estamation.each_notification(to + cc) do |users|
        EstamationMailer.entry_add(entry, to, cc).deliver
    end
end
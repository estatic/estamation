Redmine::Plugin.register :estamation do
  name 'Estamation plugin'
  author 'Ivan Grunev'
  description 'This is a plugin for Redmine 3.3. This plugin allows to create estimation for projects and convert estimation to project'
  version '0.0.4'
  url 'https://github.com/estatic/Redmine_Estamation'
  author_url 'https://github.com/estatic'
  
  permission :estamation, { :estamations => [:index, :add, :edit] }, :public => false
  menu :top_menu, :estamation, { :controller => 'estamations', :action => 'index' }, :caption => 'Estamations', :before => :help,
        :if => Proc.new{User.current.allowed_to?({:controller => 'estamations', :action => 'index'}, nil, {:global => true})}
  menu :project_menu, :estamation, { :controller => 'estamations', :action => 'index' }, :caption => 'Estimation', :after => :activity, :param => :project_id,
        :if => Proc.new{User.current.allowed_to?({:controller => 'estamations', :action => 'index'}, nil, {:global => true})}
end

class EstamationsController < ApplicationController
  unloadable
  
  helper :watchers
  include WatchersHelper
  helper :issues
  include IssuesHelper
  helper :attachments
  include AttachmentsHelper
  
  def index
      @estamations = Estamation.all
      logger.debug(@estamations)
  end
  
  def index_w_project
  end
  
  def add
      @estamation = Estamation.new
      @estamation.user_id = User.current.id
      @available_watchers = (User.all.sort + @estamation.watcher_users).uniq
      @projects = ([Project.new] + Project.active).uniq
  end

  def edit
      set_estamation
      @available_watchers = (User.all.sort + @estamation.watcher_users).uniq
      @projects = ([Project.new] + Project.active).uniq
  end
  
  def show
      set_estamation
      @newentry = @estamation.estamation_entries.new
      @newentry.user_id = User.current.id
  end

  def create
      @estamation = Estamation.new(params[:estamation])
      @estamation.save_attachments(params[:attachments] || (params[:estamation] && params[:estamation][:uploads]))
      
      respond_to do |format|
        if @estamation.save
          format.html {
              flash[:notice] = l(:notice_estamation_successful_create, :id => view_context.link_to("##{@estamation.id}", estamation_path(@estamation), :title => @estamation.title))
              unless @estamation.project.nil?
                attrs = {}
                redirect_to project_estamation_path(@estamation.project, @estamation)
              else
                redirect_to estamation_path(@estamation)
              end
          }
          format.json { render action: 'show', status: :created, location: @estamation }
        else
          format.html { render action: 'add' }
          format.json { render json: @estamation.errors, status: :unprocessable_entity }
        end
      end
  end
  
  def update
      set_estamation
      @estamation.save_attachments(params[:attachments] || (params[:estamation] && params[:estamation][:uploads]))
      respond_to do |format|
        if @estamation.update_attributes(params[:estamation])
          format.html {
              flash[:notice] = l(:notice_estamation_successful_updated, :id => view_context.link_to("##{@estamation.id}", estamation_path(@estamation), :title => @estamation.title))
              unless @estamation.project.nil?
                attrs = {}
                redirect_to project_estamation_path(@estamation.project, @estamation)
              else
                redirect_to estamation_path(@estamation)
              end
          }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @estamation.errors, status: :unprocessable_entity }
        end
      end
  end

  def change_status
  end
  
  private
  def set_estamation
      if params[:project_id].nil?
          @estamation = Estamation.find(params[:id])
      else
          @estamation = Estamation.where({:id => params[:id], :project_id => params[:project_id]}).first
      end
  end
end

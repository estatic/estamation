class EstamationEntryController < ApplicationController
  unloadable

  def create
      @estamation = Estamation.find(params[:estamation_id])
      @newentry = @estamation.estamation_entries.new(params[:estamation_entry])
      @newentry.save_attachments(params[:attachments] || (params[:estamation_entry] && params[:estamation_entry][:uploads]))
      
      respond_to do |format|
        if @newentry.save
          format.html {
              flash[:notice] = l(:notice_estamation_entry_successful_create)
              unless @estamation.project.nil?
                attrs = {}
                redirect_to project_estamation_path(@estamation.project, @estamation)
              else
                redirect_to estamation_path(@estamation)
              end
          }
          format.json { render action: 'show', status: :created, location: @estamation }
        else
          format.html { render controller: 'estamations', action: 'show' }
          format.json { render json: @newentry.errors, status: :unprocessable_entity }
        end
      end
  end
end

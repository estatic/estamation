class EstamationEntryController < ApplicationController
  unloadable

  def create
      @estamation = Estamation.find(params[:estamation_id])
      @newentry = @estamation.estamation_entries.create(entry)
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

  private
  def entry
    params.require(:estamation_entry).permit(:note, :private, :hours_min, :hours_max, :estamation, :user)
  end
end

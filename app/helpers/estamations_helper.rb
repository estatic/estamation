module EstamationsHelper
    def get_estamation_path(estamation)
        unless estamation.project.nil?
            return project_estamation_path(estamation.project.id, estamation.id)
        else
            return estamation_path(estamation.id)
        end
    end
end

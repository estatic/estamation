module EstamationsHelper
    def get_estamation_path(estamation)
        unless estamation.project.nil?
            return project_estamation_path(estamation.project, self)
        else
            return estamation_path(estamation)
        end
    end
end

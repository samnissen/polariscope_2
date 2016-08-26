class DidYouMeanTypesController < InheritedResources::Base

  private

    def did_you_mean_type_params
      params.require(:did_you_mean_type).permit(:description, :key, :archived)
    end
end


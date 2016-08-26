class DidYouMeansController < InheritedResources::Base

  private

    def did_you_mean_params
      params.require(:did_you_mean).permit(:action_status_id, :possibility, :did_you_mean_type_id)
    end
end


class XDidYouMeansController < InheritedResources::Base

  private

    def x_did_you_mean_params
      params.require(:x_did_you_mean).permit(:action_status_id, :possibility, :did_you_mean_type_id)
    end
end

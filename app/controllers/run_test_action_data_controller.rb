class RunTestActionDataController < InheritedResources::Base

  private

    def run_test_action_datum_params
      params.require(:run_test_action_datum).permit(:data, :run_object_identifier_id)
    end
end


class RunTestsController < InheritedResources::Base

  private

    def run_test_params
      params.require(:run_test).permit(:name, :description, :belongs_to, :belongs_to)
    end
end


class AddLinksBackToTestDataFromRunData < ActiveRecord::Migration
  def change
    rename_table :run_object_identifers, :run_object_identifiers
    rename_table :run_object_identifer_siblings, :run_object_identifier_siblings

    add_reference :run_tests, :testset, index: true
    add_reference :run_object_identifiers, :object_identifier, index: true
    add_reference :run_object_identifier_siblings, :object_identifier_sibling, index: true, index: {:name => "index_run_oi_siblings_on_oi_sibling_id"}
    add_reference :run_test_action_data, :test_action_data, index: true
  end
end

module TestActionsHelper
  def name_display_helper(ta)
    if ta.pointer
      pointed_to_test = Testset.where(id: ta.pointer).first

      return %{<span class='pointer-name'>Pointer:</span>
       '#{link_to pointed_to_test.name,
       collection_testset_path(pointed_to_test.collection, pointed_to_test),
       :class => 'pointer-link'}'
     }.gsub(/\s+/, ' ').html_safe
    else
      ta.name
    end
  end

  def activity_display_helper(ta)
    if ta.pointer
      'n/a'
    else
      ta.activity.action_name
    end
  end

  def onclick_url_switcher(ta)
    if ta.pointer
      pointed_to_test = Testset.where(id: ta.pointer).first
      return %{location.href='#{collection_testset_path(pointed_to_test.collection, pointed_to_test)}'}
    else
      %{location.href='#{edit_collection_testset_test_action_path(ta.testset.collection, ta.testset, ta)}'}
    end
  end

  def object_identifier_display_helper(ta, current_user)
    if ta.pointer
      return "<h4>(n/a)</h4>".html_safe
    elsif !ta.activity.object_required && !ta.activity.data_required
      return "<h4>(n/a)</h4>".html_safe
    else
      if ta.activity.object_required
        if ta.object_identifier
          display_link = link_to "Create sibling",
                  new_collection_testset_test_action_object_identifier_object_identifier_sibling_path(ta.testset.collection, ta.testset, ta, ta.object_identifier),
                  :class => 'btn btn-xxs btn-primary'
        else
          display_link = link_to "Create object",
                  new_collection_testset_test_action_object_identifier_path(ta.testset.collection, ta.testset, ta),
                  :class => 'btn btn-xxs btn-primary'
        end
      elsif ta.activity.data_required
        # Create object_identifier if none exists.
          # DONE: In order to do this, the API needs to be updated
          #  with the actual values for the booleans required (below).
          # DONE: But, also, there needs to be an object_identifer which
          #  represents a 'nil' object.
          # And ObjectIdentifer#Update view should not show the nil object.
        # Also, need to create a :before_save listener on
        # test_action -> when the activity changes,
        # appropriately modify or destroy a nil object_identifier
        display_link = link_to "Manage data",
        edit_collection_testset_test_action_object_identifier_path(ta.testset.collection, ta.testset, ta, ta.object_identifier),
                :class => 'btn btn-xxs btn-primary'
      else
        display_link = ''
      end

      if (current_user == ta.testset.user)
        return "<h4>Test Data #{display_link.html_safe}</h4>".html_safe
      else
        return "<h4>Test Data</h4>".html_safe
      end
    end
  end

  def cursor_hand_pointer_helper(ta)
    ' cursor-hand' unless ta.pointer
  end
end

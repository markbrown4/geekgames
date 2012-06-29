Then /^the "([^"]*)" field(?: within (.*))? should be empty$/ do |field, parent|
  with_scope(parent) do
    field = find_field(field)
    field_value = (field.tag_name == 'textarea') ? field.text : field.value
    if field_value.respond_to? :should
      field_value.should == ""
    else
      assert_match(/#{value}/, "")
    end
  end
end
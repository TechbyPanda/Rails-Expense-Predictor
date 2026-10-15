require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "about page presents the project and its learning notes" do
    get about_path

    assert_response :success
    assert_select "h1", "Make room for what’s coming."
    assert_select "#field-notes"
    assert_select "#learning-notes"
    assert_select "summary", text: /How does Stimulus connect/
  end

  test "former project pages redirect to their sections on about" do
    get problems_path
    assert_redirected_to "/about#field-notes"

    get interview_questions_path
    assert_redirected_to "/about#learning-notes"
  end
end
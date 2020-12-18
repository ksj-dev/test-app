require 'test_helper'

class AnimedbControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get animedb_index_url
    assert_response :success
  end

end

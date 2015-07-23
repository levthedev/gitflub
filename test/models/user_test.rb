require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @lev ||= User.new(nickname: "levthedev")
  end

  def test_it_has_correct_attributes_with_mock_lobster
    fake_graph = mock(colors: ["#f5f5dc", "#D6E685", "#8CC665", "#44A340", "#1E6823"])
    @lev.stub(contributions: fake_graph)
    assert_equal @lev.contributions.colors, ["#f5f5dc", "#D6E685", "#8CC665", "#44A340", "#1E6823"]
  end
end

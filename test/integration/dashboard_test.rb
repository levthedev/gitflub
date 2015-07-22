class DashboardTest < ActionDispatch::IntegrationTest
include Capybara::DSL

  def setup
    Capybara.app = Secretic::Application
    stub_omniauth
    current_user = mock(token: User.last)
    @client.stub(token: User.last.token,
                 user: User.last,
                 nickname: "levthedev",
                 user_events: ["1", "2"])
  end

  def test_it_logs_in
    visit '/dashboard'
    assert page.has_content?("levthedev")
  end

  def stub_omniauth
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
        provider: 'github',
        extra: {
          raw_info: {
            user_id: "11400051",
            name: "levthedev",
          }
        },
        credentials: {
          token: User.last.token,
        },
        info: {
          image: "https://avatars.githubusercontent.com/u/8868319?v=3",
          nickname: "levthedev"
        }
      })
  end
end

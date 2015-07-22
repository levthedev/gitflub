class DashboardTest < ActionDispatch::IntegrationTest
include Capybara::DSL

  def setup
    Capybara.app = Secretic::Application
    stub_omniauth
    @client.stub(token: User.last.token, nickname: "levthedev")
  end

  def test_it_logs_in
    visit '/dashboard'
    save_and_open_page
    assert page.has_content?("levthedev")
  end

  def stub_omniauth
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
        provider: 'github',
        extra: {
          raw_info: {
            user_id: "1234",
            name: "levthedev",
          }
        },
        credentials: {
          token: "pizza",
        },
        info: {
          image: "https://avatars.githubusercontent.com/u/8868319?v=3",
          nickname: "worace"
        }
      })
  end
end

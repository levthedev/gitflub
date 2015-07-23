class DashboardTest < ActionDispatch::IntegrationTest
include Capybara::DSL

  def setup
    Capybara.app = Secretic::Application
    stub_omniauth
  end

  def test_it_logs_in
    VCR.use_cassette("dashboard lev") do
      visit '/'
      click_on 'Login'
      assert page.has_content?("levthedev")
    end
  end

  def test_it_displays_follow_stats
    VCR.use_cassette("dashboard lev") do
      visit '/'
      click_on 'Login'
      assert page.has_content?("Followers: 10 ")
      assert page.has_content?("Following: 23")
    end
  end

  def test_it_displays_social_stats
    VCR.use_cassette("dashboard lev") do
      visit '/'
      click_on 'Login'
      assert page.has_content?("Starred: 12")
      assert page.has_content?("Organizations: turingschool")
    end
  end

  def test_it_displays_users_feed
    VCR.use_cassette("dashboard lev") do
      visit '/'
      click_on 'Login'
      assert page.has_css?(".feed", count: 21)
    end
  end

  def test_it_shows_user_timeline
    VCR.use_cassette("dashboard lev") do
      visit '/'
      click_on 'Login'
      assert page.has_css?(".event", count: 6)
      assert page.has_content?("turingschool/ruby-submissions")
    end
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
          token: ENV["github_sample_token"],
        },
        info: {
          image: "https://avatars.githubusercontent.com/u/8868319?v=3",
          nickname: "levthedev"
        }
      })
  end
end

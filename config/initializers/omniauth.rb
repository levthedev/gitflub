Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, ENV['github_key'], ENV['github_secret']
end

Octokit.configure do |c|
  c.login = ENV['github_login']
  c.password = ENV['github_password']
end

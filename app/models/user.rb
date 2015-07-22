class User < ActiveRecord::Base
  require 'nokogiri'
  require 'hurley'

  def self.find_or_create_from_oauth(oauth)
    user = User.find_or_create_by(provider: oauth.provider, uid: oauth.uid)
    user.email     = oauth.info.email
    user.nickname  = oauth.info.nickname
    user.image_url = oauth.info.image
    user.token     = oauth.credentials.token
    user.save
    user
  end

  def contributions
    chart = GithubChart.new(nickname)
    chart.colors = ["#f5f5dc", "#D6E685", "#8CC665", "#44A340", "#1E6823"]
    chart
  end

  def timeline
    client   = Hurley::Client.new("http://github.com/")
    body     = client.get("/").body
    document = Nokogiri::HTML(body)
    alerts   = document.css(".alert")
  end

  def contribution_stats
    client          = Hurley::Client.new("http://github.com/")
    body            = client.get("#{nickname}").body
    document        = Nokogiri::HTML(body)
    contributions   = document.css(".contrib-number")
    c = contributions.to_s
    c.delete(',').gsub(/[^0-9]/, '/').split('/').reject(&:empty?)
  end
end

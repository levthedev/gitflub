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
    # client   = Hurley::Client.new("http://github.com/users")
    # body     = client.get("#{nickname}/contributions").body
    # document = Nokogiri::HTML(body.gsub("eeeeee", "C3C3C3"))
  end
end

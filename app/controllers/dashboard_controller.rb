class DashboardController < ApplicationController
  def show
    @client ||= Octokit::Client.new(access_token: current_user.token)
    @feed ||= @client.user_events(current_user.nickname)
  end
end

class DashboardController < ApplicationController
  def show
    @client = Octokit::Client.new(access_token: current_user.token)
  end
end

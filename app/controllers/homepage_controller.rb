class HomepageController < ApplicationController
  def index
      render({ :template => "homepage/index.html.erb" })
  end
end

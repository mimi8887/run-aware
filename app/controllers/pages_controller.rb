class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :style ]

  def home
  end

  def style
  end
end

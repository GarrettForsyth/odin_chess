class StaticPagesController < ApplicationController
  before_action :authenticate_user!, except: [:home]

  def home; end

  def lobby
    @seeklist = Seeklist.find_by(name: 'lobby')
    @seeklist ||= Seeklist.create(name: 'lobby')
    @seek = Seek.new
  end
end

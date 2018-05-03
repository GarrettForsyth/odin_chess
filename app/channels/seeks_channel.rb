class SeeksChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'seeks'
  end
end

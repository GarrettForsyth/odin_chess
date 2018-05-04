# This object becomes the parent of all the channel subscriptions
# that are created from there on. The connection itself does not
# deal with any specific application logic beyond authentication
# and authorization.
module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
      logger.add_tags 'ActionCable', current_user.email
    end

    protected

    # this checks whether a user is authenticated with devise
    def find_verified_user
      if verified_user = env['warden'].user
        verified_user
      else
        reject_unauthorized_connection
      end
    end
  end
end

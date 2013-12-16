#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

class ${ClassName}
  helpers do
    def current_user
      guest = Guest.new
      return guest unless cookie_exists? 'userid'
      User.first(:session => get_cookie('sessid')) || guest
    end

    def logged_in?
      current_user.is_a? User
    end
      alias_method :logged?, :logged_in?
  end
end
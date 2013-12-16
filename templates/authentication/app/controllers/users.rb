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
  post '/user/login/?' do
    if logged_in?
      return 'You are already logged in.'
    end

    if User.login params[:username], params[:password]
      'Login successful.'
    else
      'Login failed.'
    end
  end

  post '/user/logout/?' do
    if logged_in?
      current_user.logout!
      'Logout successful.'
    else
      'You are not logged in.'
    end
  end

  post '/user/signup/?' do
    if logged_in?
      return 'You are already logged in.'
    end

    if User.exists? params[:username]
      'The username you have chosen is already taken.'
    else
      user = User.new params[:username], params[:email], params[:password], User.user
      if user.errors.any?
        user.errors.first
      else
        'Sign up successful.'
      end
    end
  end

  post '/user/lost_password/?' do
    if logged_in?
      return 'You are already logged in.'
    end

    if User.exists? params[:username]
      User.lost_password params[:username]
    else
      'The given username doesn\'t exists.'
    end
  end

  post '/user/password_recovery/?' do
    if logged_in?
      return 'You are already logged in.'
    end

    if User.password_recovery params[:username], params[:passcode], params[:password]
      'Password set successful.'
    else
      'Error setting the password.'
    end
  end

  post '/user/new_password/?' do
    unless logged_in?
      return 'You need to log in.'
    end

    user = current_user.new_password params[:curr_password], params[:password]
    if user
      'Your new password has been set.'
    else
      'Error setting your new password.'
    end
  end
end

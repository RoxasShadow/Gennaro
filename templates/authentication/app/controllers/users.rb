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
  get '/user/login/?' do
    @error = 'You are already logged in.' if logged_in?
    erb :'user/login'
  end

  get '/user/logout/?' do
    if logged_in?
      current_user.logout!
      delete_login!
      @success = 'Logout successful.'
    else
      @error   = 'You are not logged in.'
    end

    erb :'user/logout'
  end

  get '/user/signup/?' do
    @error = 'You are already logged in.' if logged_in?
    erb :'user/signup'
  end

  get '/user/lost_password/?' do
    @error = 'You are already logged in.' if logged_in?
    erb :'user/lost_password'
  end

  get '/user/password_recovery/?' do
    @error = 'You are already logged in.' if logged_in?
    erb :'user/password_recovery'
  end

  post '/user/login/?' do
    if not fields? :username, :password
      @error   = 'You have to complete all the required fields.'
    elsif logged_in?
      @error   = 'You are already logged in.'
    else
      session  = User.login params[:username], params[:password]
      if session
        set_login! session
        @success = 'Login successful.'
      else
        @error   = 'Login failed.'
      end
    end

    erb :'user/login'
  end

  post '/user/signup/?' do
    if not fields? :username, :email, :password
      @error   = 'You have to complete all the required fields.'
    elsif logged_in?
      @error = 'You are already logged in.'
    elsif User.exists? params[:username]
      @error = 'The username you have chosen is already taken.'
    else
      level = User.empty? ? User.founder : User.user
      user  = User.signup params[:username], params[:email], params[:password], level
      if user.errors.any?
        @error   = user.errors.first
      else
        @success = 'Sign up successful.'
      end
    end

    erb :'user/signup'
  end

  post '/user/lost_password/?' do
    if not fields? :username
      @error   = 'You have to complete all the required fields.'
    elsif logged_in?
      @error   = 'You are already logged in.'
    elsif User.exists? params[:username]
      passcode = User.lost_password params[:username]
      # send a mail or what you want
      @success = 'You should receive a mail with the instructions to recover your password.'
    else
      @error   = 'The given username doesn\'t exists.'
    end

    erb :'user/lost_password'
  end

  post '/user/password_recovery/?' do
    if not fields? :username, :passcode, :password
      @error   = 'You have to complete all the required fields.'
    elsif logged_in?
      @error   = 'You are already logged in.'
    elsif User.password_recovery params[:username], params[:passcode], params[:password]
      @success = 'Password set successful.'
    else
      @error   = 'Error setting the password.'
    end

    erb :'user/password_recovery'
  end
end
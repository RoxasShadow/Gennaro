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
  before do
    @title        = '${ClassName}'
    @language     = request.env['HTTP_ACCEPT_LANGUAGE']
    @current_url  = "http://#{request.env['HTTP_HOST']}#{request.env['REQUEST_URI']}"
    @domain       = "http://#{request.env['HTTP_HOST']}"
  end

  get '/' do
    'Hello, world!'
  end
end
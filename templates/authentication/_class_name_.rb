#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

require 'sinatra/base'
require 'bcrypt'
require 'data_mapper'
require 'dm-sqlite-adapter'
require 'rack/csrf'

class ${ClassName} < Sinatra::Base
  db_path = File.join Dir.pwd, 'db'
  Dir.mkdir db_path unless Dir.exists? db_path
  DataMapper.setup :default, "sqlite3://#{db_path}/app.db"

  configure {
    use Rack::Session::Cookie,
      :path   => '/',
      :secret => '${GenerateString}'

    use Rack::Csrf,
      :raise => true,
      :field => '_csrf'
  }

  Dir.glob("#{Dir.pwd}/app/helpers/*.rb")     { |h| require h.chomp }
  Dir.glob("#{Dir.pwd}/app/models/*.rb")      { |m| require m.chomp }
  Dir.glob("#{Dir.pwd}/app/controllers/*.rb") { |c| require c.chomp }

  DataMapper.finalize
  DataMapper.auto_upgrade!
end
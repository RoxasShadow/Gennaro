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
    def set_cookie(key, value, path = '/', expires = nil)
      response.set_cookie key, {
        :value   => value,
        :path    => path,
        :expires => expires || Time.now + 24 * 60 * 60
      }
    end

    def delete_cookie(key)
      response.set_cookie key, {
        :value   => '',
        :expires => Time.now
      }
    end

    def cookie_exists?(key)
      request.cookies.include? key
    end

    def get_cookie(key)
      cookie_exists?(key) ? request.cookies[key] : nil
    end
  end
end
#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

class User
  include DataMapper::Resource

  property :id,       Serial
  property :username, String, :unique => true,
                              :length => 4..16,
                              :format => /^[a-zA-Z0-9_\-\*^]*$/
  property :email,    String, :unique => true,
                              :format => :email_address

  property :permission_level, Integer, :default => 3,
                                       :max     => 3

  property :salt,             String, :length => 29
  property :salted_password,  String, :length => 60
  property :lost_password,    String
  property :session,          String

  property :created_at,       DateTime
  property :updated_at,       DateTime

  def password=(password)
    self.salt = BCrypt::Engine.generate_salt
    self.salted_password = BCrypt::Engine.hash_secret password, self.salt
  end

  def founder?
    self.id == 1
  end

  def admin?
    self.permission_level == User.admin
  end

  def smod?
    self.permission_level == User.smod
  end
    alias_method :gmod?, :smod?

  def mod?
    self.permission_level == User.mod
  end

  def user?
    self.permission_level == User.user
  end

  def banned?
    self.permission_level == User.banned
  end

  def guest?
    false
  end

  def logged?(session)
    self.session == session
  end
    alias_method :logged_in?, :logged?

  def logout
    self.session = ''
    true
  end
    alias_method :logout!, :logout

  def new_password(curr_password, password)
    return false unless self.salted_password == BCrypt::Engine.hash_secret(curr_password, self.salt)
    self.password = password
  end

  class << self
    def banned
      -1
    end

    def admin
      0
    end

    def smod
      1
    end
      alias_method :gmod, :smod

    def mod
      2
    end

    def user
      3
    end

    def guest
      4
    end

    def get(username)
      User.first(:username => username)
    end

    def exists?(username)
      User.count(:username => username) == 1
    end
    
    def registration(username, email, password, permission_level, stuff = {})
      User.create({
        :username         => username,
        :email            => email,
        :password         => password,
        :permission_level => permission_level
      }.merge(stuff))
    end
      alias_method :signup, :registration

    def authentication(username, password)
      user = User.first(:username => username)
      return false unless user
      if user.salted_password == BCrypt::Engine.hash_secret(password, user.salt)
        user.update(:session => BCrypt::Engine.generate_salt)
      else
        false
      end
    end
      alias_method :login,        :authentication
      alias_method :signin,       :authentication
      alias_method :authenticate, :authentication

    def logout(username)
      user = User.first(:username => username)
      return false unless user
      user.update(:session => '')
      user.session.empty?
    end
      alias_method :logout!, :logout

    def logged?(username, session)
      User.count(:username => username, :session => session) == 1
    end
      alias_method :logged_in?, :logged?

    def lost_password(username)
      user = User.first(:username => username)
      return false unless user
      user.update(:lost_password => BCrypt::Engine.generate_salt)
      user.lost_password
    end

    def password_recovery(username, lost_password, password)
      user = User.first({
        :username      => username,
        :lost_password => lost_password
      })
      return false unless user
      return false if     user.lost_password.empty?
      user.update({
        :lost_password => '',
        :password      => password
      })
    end

    def new_password(username, curr_password, password)
      user = User.first(:username => username)
      return false unless user
      return false unless user.salted_password == BCrypt::Engine.hash_secret(curr_password, user.salt)
      user.update(:password => password)
    end
  end
end
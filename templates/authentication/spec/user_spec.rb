ENV['RACK_ENV'] = 'test'

require './spec'
require 'rspec'
require 'rack/test'

describe 'App' do
  def app
    Sinatra::Application
  end

  it 'creates an user' do
    username = 'Gennaro'
    email    = 'gennaro@bullo.pk'
    password = 'sonopropriounbullo!'
    permission_level = User.user

    User.exists?(username).should be_false
    user = User.signup username, email, password, permission_level
    user.errors.should be_empty
    user.guest?.should be_false
    user.user?.should  be_true
    User.exists?(username).should be_true

    user = User.signup username, email, password, permission_level
    user.errors.should_not be_empty
  end

  it 'logs in a user' do
    username = 'Gennaro'
    password = 'sonopropriounbullo!'

    User.exists?(username).should be_true
    User.login(username, password).should be_true
    user = User.get username
    user.session.should have(29).chars
  end

  it 'logs out a user' do
    username = 'Gennaro'

    user = User.get username
    user.session.should have(29).chars
    user.logout
    user.session.should be_empty
  end

  it 'recovers lost password' do
    username     = 'Gennaro'
    new_password = 'sonounnuovobullo!'

    User.login(username, new_password).should be_false

    passcode = User.lost_password username
    passcode.should_not be_false
    passcode.should have(29).chars

    recovery = User.password_recovery username, passcode, new_password
    recovery.should be_true

    User.login(username, new_password).should be_true
  end

  it 'set a new password' do
    username      = 'Gennaro'
    curr_password = 'sonounnuovobullo!'
    password      = 'sonopropriounbullo!'

    User.login(username, curr_password).should be_true
    User.new_password(username, curr_password, password).should be_true
    User.login(username, password).should be_true
  end
end

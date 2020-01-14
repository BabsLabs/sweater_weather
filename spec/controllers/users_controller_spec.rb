require 'rails_helper'

describe Api::V1::UsersController do
  it "can make a user", :vcr do

    WebMock.enable_net_connect!
VCR.eject_cassette
VCR.turn_off!(ignore_cassettes: true)

  @request.headers['email'] = 'email@email.com'
  @request.headers['password'] = 'password'
  @request.headers['password_confirmation'] = 'password'

  post :create

  expect(response).to be_successful

  end
end
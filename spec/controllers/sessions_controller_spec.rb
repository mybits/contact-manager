require 'spec_helper'

describe SessionsController do

  describe "#create" do

  before(:each) do
    Rails.application.routes.draw do
    resource :sessions, only: [:create, :destroy]
    root to: 'site#index'
    end
  end

  after(:each) do
    Rails.application.reload_routes!
  end

    it "logs in a new user" do
      @request.env["omniauth.auth"] = {
        'provider' => 'twitter',
        'info' => {'name' => 'Alice Smith'},
        'uid' => 'abc123'
      }

      post :create
      user = User.find_by_uid_and_provider('abc123', 'twitter')
      expect(controller.current_user.id).to eq(user.id)
    end

    it "logs in an existing user" do
      @request.env["omniauth.auth"] = {
        'provider' => 'twitter',
        'info' => { 'name' => 'Bob Smith' },
        'uid' => 'xyz456'
      }

      user = User.create(provider: 'twitter', uid: 'xyz456', name: 'Bob Smith')

      post :create
      expect(User.count).to eq(1)
      expect(controller.current_user.id).to eq(user.id)
    end


    it "redirects to the sites page" do
      @request.env["omniauth.auth"] = {
        'provider' => 'twitter',
        'info' => { 'name' => 'Ed Wood'},
        'uid' => 'efg321'
      }

      user = User.create(provider: 'twitter', uid: 'efg321', name: 'Ed Wood')
      post :create
      expect(response).to redirect_to(root_path)
    end
  end

  describe "#destroy" do

    it "logs out a user" do
      @request.env["omniauth.auth"] = {
        'provider' => 'twitter',
        'info' => {'name' => 'Alice Smith'},
        'uid' => 'abc123'
      }

      post :create
      user = User.find_by_uid_and_provider('abc123', 'twitter')

      delete :destroy
      session[:user_id].should be_nil
    end

    it "redirects to the sites page" do

      @request.env["omniauth.auth"] = {
        'provider' => 'twitter',
        'info' => {'name' => 'Alice Smith'},
        'uid' => 'abc123'
      }

      post :create
      user = User.find_by_uid_and_provider('abc123', 'twitter')

      delete :destroy
      expect(response).to redirect_to(root_path)
    end



  end
end

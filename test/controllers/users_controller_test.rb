require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:dave)

    @sam = {
      name: "sam",
      password: "private",
      password_confirmation: "private"
    }
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      #post :create, user: { name: 'sam',
      #                      password: 'secret',
      #                      password_confirmation: 'secret' }
      post :create, user: @sam
    end

    assert assigns(:user)
    assert_redirected_to users_path
  end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user
    assert_response :success
  end

  test "should update user" do
    assert_not_nil @user.id, "Should not be nil"
    assert defined?(session), "Should be defined"
    assert_equal @user.id, session[:user_id], "Should be equal"

    #post :create, name: @user.name, password: 'secret' 
    #patch :update,
    #      id: @user,
    #      user: { name: @user.name,
    #              password: 'new_secret',
    #              password_confirmation: 'new_secret' }
    put :update, id: @user.to_param, user: @sam
    assert assigns(:user), "Should be assigned"
    assert_redirected_to users_path
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_redirected_to users_path
  end
end

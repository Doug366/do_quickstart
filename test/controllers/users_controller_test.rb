require 'test_helper'
require 'faker'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
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
#      post :create, user: { email: @user.email, first_name: @user.first_name, last_name: @user.last_name }
      first_name = Faker::Name.first_name
      last_name = Faker::Name.last_name
      domain_name = Faker::Internet.domain_name
      email = "#{first_name}.#{last_name}#{"@"}#{domain_name}"
      post :create, user: { first_name: first_name, last_name: last_name, email: email }
    end

    assert_redirected_to user_path(assigns(:user))
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
    patch :update, id: @user, user: { email: @user.email, first_name: @user.first_name, last_name: @user.last_name }
    assert_redirected_to user_path(assigns(:user))
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_redirected_to users_path
  end
end

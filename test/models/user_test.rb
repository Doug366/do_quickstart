require 'minitest/spec'
require 'minitest/autorun'
require 'faker'

class UserTest < ActiveSupport::TestCase
  describe User do
    before do
      first_name = Faker::Name.first_name
      last_name = Faker::Name.last_name
      domain_name = Faker::Internet.domain_name
      email = "#{first_name}.#{last_name}#{"@"}#{domain_name}"
      @user = User.new(first_name: first_name, last_name: last_name, email: email)
    end

    after do
      @user.destroy
    end

    it "must be instance of User" do
      @user.must_be_instance_of User
    end

    it "must be valid" do
      @user.must_be :valid?
    end

    it "first_name must be present" do
      @user.first_name = ""
      @user.wont_be :valid?
    end

    it "first_name must not be too long" do
      @user.first_name = "a" * 51
      @user.wont_be :valid?
    end

    it "last_name must be present" do
      @user.last_name = ""
      @user.wont_be :valid?
    end

    it "last_name must not be too long" do
      @user.last_name = "b" * 51
      @user.wont_be :valid?
    end

    it "email must be present" do
      @user.email = ""
      @user.wont_be :valid?
    end

    it "email must not be too long" do
      @user.email = "a" * 244 + "@example.com"
      @user.wont_be :valid?
    end

    it "email must accept valid addresses" do
      valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                     first.last@foo.jp alice+bob@baz.cn]
      valid_addresses.each do |valid_address|
        @user.email = valid_address
        @user.must_be :valid?, "#{valid_address.inspect} should be valid"
      end
    end

    it "email wont accept invalid addresses" do
      invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                       foo@bar_baz.com foo@bar+baz.com]
      invalid_addresses.each do |invalid_address|
        @user.email = invalid_address
        @user.wont_be :valid?, "#{invalid_address.inspect} should be invalid"
      end
    end

    it "email wont accept non-unique case_insensitive address" do
      duplicate_user = @user.dup
      duplicate_user.email = @user.email.upcase
      @user.save
      duplicate_user.wont_be :valid?
    end

    it "email must be saved as lower-case" do
      mixed_case_email = "Foo@ExAMPle.CoM"
      @user.email = mixed_case_email
      @user.save
      mixed_case_email.downcase.must_equal @user.reload.email
    end

    it "returns full_name" do
      @user.full_name.must_equal "#{@user.first_name} #{@user.last_name}"
    end
  end
end

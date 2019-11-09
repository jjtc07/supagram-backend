require "rails_helper"

RSpec.describe User, type: :model do

  user_factory = UserFactory.new()

  it "creates a User with name, username, email and password" do
    user = user_factory.create()
    expect(User.first).to eq(user);
  end

  it "must have a name" do
    user = user_factory.create_without_name()
    expect(user.valid?()).to be(false)
  end

  it "must have a name of at least 2 characters" do
    user = user_factory.create(name: "a")
    expect(user.valid?()).to be(false)
  end

  it "must have a name no longer than 50 characters" do
    user = user_factory.create(name: ("a" * 51))
    expect(user.valid?()).to be(false)
  end

  it "must not have a name with special characters other than ' -" do
    user = user_factory.create(name: "Te@s_.t")
    expect(user.valid?()).to be(false)
  end

  it "must not have a name that contains numbers" do
    user = user_factory.create(name: "Test1")
    expect(user.valid?()).to be(false)
  end

  it "must have a name that starts with a letter" do
    user = user_factory.create(name: " Test")
    expect(user.valid?()).to be(false)
  end

  it "must have a name that ends with a letter" do
    user = user_factory.create(name: "Test ")
    expect(user.valid?()).to be(false)
  end

  it "converts name to title case before save" do
    user = user_factory.create(name: "test user")
    expect(user.name).to eq("Test User")
  end

  it "must have a username" do
    user = user_factory.create_without_username()
    expect(user.valid?()).to be(false)
  end

  it "must have a username of at least 4 characters" do
    user = user_factory.create(username: "Tes")
    expect(user.valid?()).to be(false)
  end

  it "must have a username of no more than 30 characters" do
    user = user_factory.create(username: ("a" * 31))
    expect(user.valid?()).to be(false)
  end

  it "must have a unique username" do
    user1 = user_factory.create()
    user2 = user_factory.create(username: user1.username)
    expect(user2.valid?()).to be(false)
  end

  it "must have a username that starts with a letter, number or _" do
  end

  it "must have a username that ends with a letter, number or _" do
  end

  it "must not have a username with two consecutive . " do
  end

  it "must not contain special characters other than . and _" do
  end

  it "cannot be created without an email" do
  end

  it "must have a unique email" do
  end

  it "cannot be created without a password" do
  end

  it "must have a password of at least 8 characters" do
  end

  it "must have a password with at least 1 special character" do
  end

  it "must have a password with at least 1 number" do
  end

  it "is created with a default avatar" do
    user = user_factory.create()
    expect(user.avatar.attached?()).to be(true)
  end

  it "can have only one attached avatar" do
  end

  it "destroys dependent Follows when it is destroyed" do
  end

  it "destroys dependent Likes when it is destroyed" do
  end

  it "returns an array of posts it has liked" do
  end

end
require "spec_helper"

describe "User" do

  context "should create a user" do
    it "should create a user" do
      user = User.new(
        name: "Gerald Wolfe",
        email: "gerald@gerald.com",
        password_digest: "12345678",
        city: "New York",
        state: "NY",
        zip: "10013",
        current_position_title: "Developer",
        employment_status: "available",
        company_name: "General Assembly"
      )
      expect(user.is_a? User).to be(true)
    end

    it "should have a name" do
      user = User.new(
        name: "Gerald Wolfe",
        email: "gerald@gerald.com",
        password_digest: "12345678",
        city: "New York",
        state: "NY",
        zip: "10013",
        current_position_title: "Developer",
        employment_status: "available",
        company_name: "General Assembly"
      )
      expect(user.name).to eq("Gerald Wolfe")
    end
  end

end

require "spec_helper"

describe "Search" do
  it "should create a search" do
    search = Search.new(
      position: "Ruby Developer",
      city: "New York",
      state: "NY",
      zip: "10003",
      industry: "Fashion",
      company: ""
    )
    expect(search.is_a? Search).to be(true)
  end

    it "should have the correct attributes" do
    search = Search.new(
      position: "Ruby Developer",
      city: "New York",
      state: "NY",
      zip: "10003",
      industry: "Fashion",
      company: ""
    )
    expect(search.position).to eq("Ruby Developer")
  end
end

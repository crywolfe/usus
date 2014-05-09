require 'time'
require 'open-uri'
require 'rack'

class LinkedinScraper < ActiveRecord::Base

attr_accessor :url, :searches

  def initialize
    @base_url = "http://"
    @searches = []
  
  end

  def build_query
  end


  def parse
   

  end

  def fetch_html
    # Load document using Nokogiri and open-uri
    # save to instance variables the arrays of data
    # to be iterated through for data capture
    @doc = Nokogiri::HTML(open(@url))
    
  end
end
require 'open-uri'

class LinkedinScraper < ActiveRecord::Base

attr_accessor :url, :searches

  def initialize
    @base_url = "https://www.linkedin.com/vsearch/p?=type=all&keywords=%22"
  end

  #builds the query to find all individuals who have the position you are looking for in your network.
  def build_outer_query
    position = params[:position]
    # &f_N=S,A S refers to 2nd tier connections
    position_plus_connections = position + "%22&f_N=S"
    # add page number
    @final_url = position_plus_connections + "&page_num=" + page_num
  end

  def build_second_query


  end


# https://www.linkedin.com/profile/view?id=9407738&amp;authType=OUT_OF_NETWORK&amp;authToken=vihm&amp;locale=en_US&amp;srchid=111602881399943004675&amp;srchindex=1&amp;srchtotal=17&amp;trk=vsrp_people_res_name&amp;trkInfo=VSRPsearchId%3A111602881399943004675%2CVSRPtargetId%3A9407738%2CVSRPcmpt%3Aprimary


  def parse


  end

  def fetch_html
    # Load document using Nokogiri and open-uri
    # save to instance variables the arrays of data
    # to be iterated through for data capture
    doc = Nokogiri::HTML(open(@final_url))
    @doc = doc.xpath("//code")[0].children
    @doc.to_s

    #first element to iterate

    "\":\"/
    element_1 = doc.split("link_nprofile_view_3\":\"")
    element_1.split("\",\"link_nprofile_view_4")[0]

  end
end

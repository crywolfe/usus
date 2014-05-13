require 'open-uri'

class LinkedinScraper < ActiveRecord::Base

attr_accessor :url, :searches

  def initialize
    @base_url_outer_query = "https://www.linkedin.com/vsearch/p?=type=all&keywords=%22"
    @base_url_inner_query = "https://www.linkedin.com"
  end

  #builds the query to find all individuals who have the position you are looking for in your network.
  def build_outer_query
    position = params[:position]
    # &f_N=S,A S refers to 2nd tier connections
    position_plus_connections = position + "%22&f_N=S"
    # add page number
    url_tail_outer_query = position_plus_connections + "&page_num=" + page_num
    @outer_query_url = @base_url_outer_query + url_tail_outer_query
  end

  def build_inner_query
    @inner_query_url = @base_url_inner_query + @url_tail

    #   https://www.linkedin.com/profile/view?id=9407738&amp;authType=OUT_OF_NETWORK&amp;authToken=vihm&amp;locale=en_US&amp;srchid=111602881399943004675&amp;srchindex=1&amp;srchtotal=17&amp;trk=vsrp_people_res_name&amp;trkInfo=VSRPsearchId%3A111602881399943004675%2CVSRPtargetId%3A9407738%2CVSRPcmpt%3Aprimary
  end

  def fetch_html
    # Load document using Nokogiri and open-uri
    # save to instance variables the arrays of data
    # to be iterated through for data capture
    nokogiri_all_text = Nokogiri::HTML(open(@outer_query_url))
    relevant_text = nokogiri_all_text.xpath("//code")[0].children
    stringified_text = relevant_text.to_s

    # first element to iterate
    element = stringified_text.split("link_nprofile_view_3\":\"")[1]
    @url_tail = element.split("\",\"link_nprofile_view_4")[0]

  end

  def fetch_skills
    profile = Nokogiri::HTML(open(@inner_query_url))


    profile_string = (profile.xpath("//code")).to_s

    profile_relevent_text = profile_string.split("\"name\":\"skills\"")[0]

    profile_length = profile_relevent_text.split("fmt__skill_name\":\"").length


    skills_array =[]
    for num in (1...profile_length-1)
      skill = profile_relevent_text.split("fmt__skill_name\":\"")[num].split("\"},{\"id")[0]
      skills_array << skill
    # last split in iteration
    end
    skills_array << profile_relevent_text.split("fmt__skill_name\":\"")[profile_length-1].split("\"}],\"")[0]

  end

end

build_outer_query
build_inner_query

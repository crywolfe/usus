require 'open-uri'

class LinkedinScraper

  attr_accessor :base_url_outer_query, :base_url_inner_query, :skills_array, :page_num

  def initialize
    @base_url_outer_query = "https://www.linkedin.com/vsearch/p?=type=all&keywords=%22"
    @base_url_inner_query = "https://www.linkedin.com"
    @skills_array = []
    @page_num = "1"
  end

  #builds the query to find all individuals who have the position you are looking for in your network.
  def build_outer_query
    position = "Javascript%20Developer"
    # &f_N=S,A S refers to 2nd tier connections
    position_plus_connections = position + "%22&f_N=S"
    # add page number
    url_tail_outer_query = position_plus_connections + "&page_num=" + @page_num
    @outer_query_url = @base_url_outer_query + url_tail_outer_query
  end

  # def build_inner_query(element)
  #   @inner_query_url = @base_url_inner_query + element
  # end

  # this method fetches each individual profile
  def fetch_profiles
    # Load document using Nokogiri and open-uri
    # save to instance variables the arrays of data
    # to be iterated through for data capture
    all_text = Nokogiri::HTML(open(@outer_query_url))
    binding.pry
    relevant_text = all_text.xpath("//code")[0].children
    stringified_text = relevant_text.to_s

    # iterate through each profile url
    for num in (1..10)
      profile_url_tail = stringified_text.split("link_nprofile_view_3\":\"")[num].split("\",\"link_nprofile_view_4")[0]
      @inner_query_url = @base_url_inner_query + profile_url_tail
      # build_inner_query(element)

      fetch_individual_skills(@inner_query_url)
    end
  end

  def fetch_individual_skills(inner_query_url)
    # create Nokogiri object from inner_query_url
    profile = Nokogiri::HTML(open(inner_query_url))
    profile_string = (profile.xpath("//code")).to_s

    # grab relevant text located at index 0
    profile_relevent_text = profile_string.split("\"name\":\"skills\"")[0]

    profile_length = profile_relevent_text.split("fmt__skill_name\":\"").length

    #create new skills_array
    #iterate and push into array
    for num in (1...profile_length-1)
      skill = profile_relevent_text.split("fmt__skill_name\":\"")[num].split("\"},{\"id")[0]
      @skills_array << skill
    # last split in iteration
    end

    # push in edge case of last element
    @skills_array << profile_relevent_text.split("fmt__skill_name\":\"")[profile_length-1].split("\"}],\"")[0]
  end

  # def fetch_all_skills
  #   #iterate individual skills
  #   for num in ()
  #   fetch_individua
  # end

end

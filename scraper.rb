# PSEUDOCODE TO SCRAPE THE 5 TOP MOVIES FROM IMDB

# 1. require needed libraries (nokogiri, open-uri, yaml)
# nokogiri: parse the info (HTML)
# open-uri: open the url to read the file URI.open(url)
# yaml: create the yaml from the ruby object 

require 'nokogiri'
require 'open-uri'
require 'yaml'


def scrape_top_movies_urls
  # 2.we need the url of the IMDB page https://www.imdb.com/chart/top
  url = "https://www.imdb.com/chart/top"
  
  # 3. read the url for top movies (inspect) and get the URL for the top 5 movies
  document_string   = URI.open(url)
  parsed_doc        = Nokogiri::HTML(document_string)
  movie_elements    = parsed_doc.search('.titleColumn')
  first_five_movies = movie_elements.slice(0,5)
  urls              = []

  first_five_movies.each do |movie_element|
    url = movie_element.search('a').first.values.first

    urls << "http://www.imdb.com#{url}"
  end

  urls
end

def scrape_movie_info(movie_url)
  # 4. parse the URL for the specific movies and get the information
  document_string   = URI.open(movie_url, "Accept-language" => "en")
  parsed_doc        = Nokogiri::HTML(document_string)

  director = parsed_doc.search(
    ".credit_summary_item"
  )[0].text.strip.gsub('Director:',"").gsub(/\n/,'')

  cast = parsed_doc.search(
    ".credit_summary_item"
  ).last.text.strip.gsub("Stars:", "").gsub(/\n/, "").gsub(
    "|See full cast & crew »", ""
  ).strip

  storyline = parsed_doc.search(".summary_text").text.strip

  title = parsed_doc.search(
    ".title_wrapper h1"
  ).text.strip.gsub(/[(0-9)]/,"")

  year = parsed_doc.search("#titleYear").text.gsub(/[()]/,"")

  # 5. Store the information for movie inside of a hash
  movie = {
    cast: cast,
    director: director,
    storyline: storyline ,
    title: title,
    year: year.to_i
  }

  movie
end

# 6. Store the hash inside of an array of movies
# p scrape_movie_info("https://www.imdb.com/title/tt0111161/")




movie_urls = scrape_top_movies_urls

movies = []

movie_urls.each do |url|
  movie = scrape_movie_info(url)
  movies <<  movie
end

# 7. Convert the array of movies into a movies.yml file
File.open("movies.yml", "w") do  |f|
  f.write(movies.to_yaml)
end
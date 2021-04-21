# data for #scrape_top_movies_urls:

# data for #scrape_movie:
# {
#   cast: [ "Christian Bale", "Heath Ledger", "Aaron Eckhart" ],
#   director: "Christopher Nolan",
#   storyline: "When the menace known as the Joker emerges from his mysterious past, he wreaks havoc and chaos on the people of Gotham. The Dark Knight must accept one of the greatest psychological and physical tests of his ability to fight injustice.",
#   title: "The Dark Knight",
#   year: 2008
# }

require_relative "../scraper"

describe "#scrape_top_movies_urls" do

  it "should return an array of movies" do
    expect(scrape_top_movies_urls).to eq([
      "http://www.imdb.com/title/tt0111161/",
      "http://www.imdb.com/title/tt0068646/",
      "http://www.imdb.com/title/tt0071562/",
      "http://www.imdb.com/title/tt0468569/",
      "http://www.imdb.com/title/tt0050083/"
    ]
    )
  end
end


describe "#scrape_movie_info(movie_url)" do
  it "should return a hash containing the information of a movie" do
    expect(scrape_movie_info('https://www.imdb.com/title/tt0468569/')).to eq(
      {
        cast: [ "Christian Bale", "Heath Ledger", "Aaron Eckhart" ],
        director: "Christopher Nolan",
        storyline: "When the menace known as the Joker emerges from his mysterious past, he wreaks havoc and chaos on the people of Gotham. The Dark Knight must accept one of the greatest psychological and physical tests of his ability to fight injustice.",
        title: "The Dark Knight",
        year: 2008
      }
    )
  end
end
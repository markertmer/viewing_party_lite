class MovieFacade
  def self.making_objects(data)
    data[:results].map do |movie|
      Movie.new(movie)
    end
  end

  def self.top_movies
    data = MovieService.find_top_movies

    making_objects(data)
    # grab the data
    # pass data to top movies
  end

  def self.lookup(keyword)
    data = MovieService.search_movies(keyword)
    making_objects(data)
  end
end

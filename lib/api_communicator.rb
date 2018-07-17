require 'rest-client'
require 'json'
require 'pry'


def get_character_movies_from_api(character)
  #make the web request
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)


# iterate over the character hash to find the collection of `films` for the given
#   `character`
# collect those film API urls, make a web request to each URL to get the info
#  for that film
#--> return value of this method should be collection of info about each film.
#  i.e. an array of hashes in which each hash reps a given film
# this collection will be the argument given to `parse_character_movies`
#  and that method will do some nice presentation stuff: puts out a list
#  of movies by title. play around with puts out other info about a given film.
answer = nil

characterArray = character_hash["results"]
 characterArray.each do |character_info|
   #add a conditional to only set answer when character name == charact (the argument we passed in)
   #binding.pry
   if character_info["name"].downcase == character
     answer = character_info["films"]
   end

 end
#-----------------
    # ANSWER IS AN ARRAY OF URLS. ITERATE AND PASS INTO GET METHOD
  superArray =  answer.map { |url| JSON.parse(RestClient.get(url))}
  superArray.each do |film_thing|
    title = film_thing["title"]
    episodeID = film_thing["episode_id"]
    openCrawl = film_thing["opening_crawl"].to_s
    #binding.pry
    puts "=" * 30
    puts title
    puts "Episode # #{episodeID}"
    puts openCrawl

  end
  #character_hash = JSON.parse(superArray)

  #end
end

def parse_character_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?

require 'uri'
require 'net/http'
require 'json'

class PokemonApiService
  BASE_URL = 'https://pokeapi.co/api/v2/'

  def fetch_pokemons
    uri = URI("#{BASE_URL}/pokemon?limit=100")
    response = Net::HTTP.get(uri)
    JSON.parse(response)['results']
  end

  def fetch_pokemon_details(url)
    uri = URI(url)
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  end
end

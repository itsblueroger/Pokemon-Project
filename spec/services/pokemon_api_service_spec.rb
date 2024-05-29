require 'rails_helper'
require 'vcr'

RSpec.describe PokemonApiService do
  describe '#fetch_pokemons' do
    it 'returns a list of pokemons' do
      VCR.use_cassette('pokemon_api_fetch_pokemons') do
        pokemons = PokemonApiService.new.fetch_pokemons
        expect(pokemons).to be_an(Array)
        expect(pokemons).not_to be_empty
      end
    end
  end

  describe '#fetch_pokemon_details' do
    it 'returns details of a pokemon' do
      VCR.use_cassette('pokemon_api_fetch_pokemon_details') do
        pokemon_url = 'https://pokeapi.co/api/v2/pokemon/1/'
        pokemon_details = PokemonApiService.new.fetch_pokemon_details(pokemon_url)
        expect(pokemon_details).to be_a(Hash)
        expect(pokemon_details['name']).to eq('bulbasaur')
      end
    end
  end
end

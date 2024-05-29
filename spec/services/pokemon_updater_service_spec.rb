# spec/services/pokemon_updater_service_spec.rb
require 'rails_helper'
require 'vcr'

RSpec.describe PokemonUpdaterService, type: :service do
  let(:service) { PokemonUpdaterService.new }

  describe '#update_pokemons' do
    it 'fetches and updates pokemons' do
      VCR.use_cassette('pokemon_api_fetch') do
        expect { service.update_pokemons }.to change { Pokemon.count }.by(100)
      end

      # Verify a specific Pokémon is updated correctly
      pokemon = Pokemon.find_by(name: 'bulbasaur')
      expect(pokemon).not_to be_nil
      expect(pokemon.base_experience).to eq(64)
      expect(pokemon.height).to eq(7)
      expect(pokemon.weight).to eq(69)
      expect(pokemon.game_id).to eq(1)
      expect(pokemon.sprite).to eq('https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png')

      # Verify types are updated correctly
      expect(pokemon.types.count).to eq(2)
      expect(pokemon.types.map(&:name)).to include('grass', 'poison')

      # Verify abilities are updated correctly
      expect(pokemon.abilities.count).to eq(2)
      expect(pokemon.abilities.map(&:name)).to include('overgrow', 'chlorophyll')

      # Verify moves are updated correctly
      expect(pokemon.moves.count).to be > 0
      move = pokemon.moves.find_by(name: 'tackle')
      expect(move).not_to be_nil
      expect(pokemon.pokemon_moves.find_by(move:).level).to eq(1)

      # Verify stats are updated correctly
      expect(pokemon.stats.count).to eq(6)
      stat = pokemon.stats.find_by(name: 'speed')
      expect(stat).not_to be_nil
      expect(pokemon.pokemon_stats.find_by(stat:).value).to eq(45)
    end

    it 'updates existing Pokémon records' do
      VCR.use_cassette('pokemon_api_fetch') do
        pokemon = Pokemon.create(
          name: 'bulbasaur',
          base_experience: 50,
          height: 6,
          weight: 60,
          game_id: 1,
          sprite: 'https://example.com/old_sprite.png'
        )

        service.update_pokemons

        pokemon.reload
        expect(pokemon.base_experience).to eq(64)
        expect(pokemon.height).to eq(7)
        expect(pokemon.weight).to eq(69)
        expect(pokemon.sprite).to eq('https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png')
      end
    end
  end
end

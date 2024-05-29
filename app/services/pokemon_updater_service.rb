# app/services/pokemon_updater_service.rb
class PokemonUpdaterService
  def initialize(api_service = PokemonApiService.new)
    @api_service = api_service
  end

  def update_pokemons
    pokemons = @api_service.fetch_pokemons

    pokemons.each do |pokemon_data|
      pokemon_details = @api_service.fetch_pokemon_details(pokemon_data['url'])

      pokemon = Pokemon.find_or_initialize_by(name: pokemon_details['name'])
      pokemon.update(
        base_experience: pokemon_details['base_experience'],
        height: pokemon_details['height'],
        weight: pokemon_details['weight'],
        game_id: pokemon_details['id'],
        sprite: pokemon_details['sprites']['front_default']
      )

      update_pokemon_types(pokemon, pokemon_details['types'])
      update_pokemon_abilities(pokemon, pokemon_details['abilities'])
      update_pokemon_moves(pokemon, pokemon_details['moves'])
      update_pokemon_stats(pokemon, pokemon_details['stats'])
    end
  end

  private

  def update_pokemon_types(pokemon, types)
    types.each do |type_data|
      type = Type.find_or_create_by(name: type_data['type']['name'])
      PokemonType.find_or_create_by(pokemon:, type:)
    end
  end

  def update_pokemon_abilities(pokemon, abilities)
    abilities.each do |ability_data|
      ability = Ability.find_or_create_by(name: ability_data['ability']['name'])
      PokemonAbility.find_or_create_by(pokemon:, ability:)
    end
  end

  def update_pokemon_moves(pokemon, moves)
    moves.each do |move_data|
      move_name = move_data['move']['name']
      next unless move_data['version_group_details'].last['move_learn_method']['name'] == 'level-up'

      move = Move.find_or_create_by(name: move_name)
      level = move_data['version_group_details'].last['level_learned_at']
      PokemonMove.find_or_create_by(pokemon:, move:, level:)
    end
  end

  def update_pokemon_stats(pokemon, stats)
    stats.each do |stat_data|
      stat = Stat.find_or_create_by(name: stat_data['stat']['name'])
      PokemonStat.find_or_create_by(pokemon:, stat:, value: stat_data['base_stat'])
    end
  end
end

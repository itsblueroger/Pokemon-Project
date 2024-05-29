# lib/tasks/pokemon.rake
namespace :pokemon do
  desc "Fetch and populate the database with Pokemon data from the API"
  task update_list: :environment do
    service = PokemonUpdaterService.new
    service.update_pokemons
    puts "Pokémon data has been successfully updated!"
  end
end

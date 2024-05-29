class AddAttributesToPokemon < ActiveRecord::Migration[7.1]
  def change
    add_column :pokemons, :base_experience, :integer
    add_column :pokemons, :height, :integer
    add_column :pokemons, :game_id, :integer
    add_column :pokemons, :sprite, :string
    add_column :pokemons, :weight, :integer
  end
end

class PokemonsController < ApplicationController
  def index
    @pokemons = Pokemon.includes(:types).all.sort_by(&:game_id)
  end

  def show
    @pokemon = Pokemon.includes(:types, :moves, :abilities, :stats).find(params[:id])
    @previous_pokemon = Pokemon.where("id < ?", @pokemon.id).order(id: :desc).first
    @next_pokemon = Pokemon.where("id > ?", @pokemon.id).order(id: :asc).first

    @pokemon_moves = @pokemon.pokemon_moves.sort_by(&:level)
  end
end

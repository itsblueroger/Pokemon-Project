class PokemonsController < ApplicationController
  def index
    @pokemons = Pokemon.includes(:types).all
  end

  def show
    @pokemon = Pokemon.includes(:types).find(params[:id])
  end
end

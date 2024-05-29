require 'rails_helper'

RSpec.describe PokemonsController, type: :controller do
  describe "GET #index" do
    it "assigns @pokemons" do
      pokemon1 = FactoryBot.create(:pokemon, name: "Pikachu")
      pokemon2 = FactoryBot.create(:pokemon, name: "Charmander")

      get :index
      expect(assigns(:pokemons)).to eq([pokemon1, pokemon2])
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "GET #show" do
    it "assigns @pokemon" do
      pokemon = FactoryBot.create(:pokemon)

      get :show, params: { id: pokemon.id }
      expect(assigns(:pokemon)).to eq(pokemon)
    end

    it "assigns @previous_pokemon and @next_pokemon" do
      pokemon1 = FactoryBot.create(:pokemon)
      pokemon2 = FactoryBot.create(:pokemon)
      pokemon3 = FactoryBot.create(:pokemon)

      get :show, params: { id: pokemon2.id }
      expect(assigns(:previous_pokemon)).to eq(pokemon1)
      expect(assigns(:next_pokemon)).to eq(pokemon3)
    end

    it "assigns @pokemon_moves" do
      pokemon = FactoryBot.create(:pokemon)
      move1 = FactoryBot.create(:move, name: "Move1")
      pokemon_move1 = FactoryBot.create(:pokemon_move, pokemon:, move: move1)
      move2 = FactoryBot.create(:move, name: "Move2")
      pokemon_move2 = FactoryBot.create(:pokemon_move, pokemon:, move: move2)

      get :show, params: { id: pokemon.id }
      expect(assigns(:pokemon_moves)).to eq([pokemon_move1, pokemon_move2])
    end

    it "renders the show template" do
      pokemon = FactoryBot.create(:pokemon)

      get :show, params: { id: pokemon.id }
      expect(response).to render_template("show")
    end
  end
end

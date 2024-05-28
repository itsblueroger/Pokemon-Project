require 'rails_helper'

RSpec.describe PokemonType, type: :model do
  it "belongs to a pokemon" do
    association = described_class.reflect_on_association(:pokemon)
    expect(association.macro).to eq :belongs_to
  end

  it "belongs to a type" do
    association = described_class.reflect_on_association(:type)
    expect(association.macro).to eq :belongs_to
  end

  it "is valid with valid attributes" do
    pokemon = Pokemon.create(name: "Pikachu")
    type = Type.create(name: "electric")
    pokemon_type = PokemonType.new(pokemon: pokemon, type: type)
    expect(pokemon_type).to be_valid
  end

  it "is invalid without a pokemon" do
    type = Type.create(name: "electric")
    pokemon_type = PokemonType.new(pokemon: nil, type: type)
    expect(pokemon_type).not_to be_valid
  end

  it "is invalid without a type" do
    pokemon = Pokemon.create(name: "Pikachu")
    pokemon_type = PokemonType.new(pokemon: pokemon, type: nil)
    expect(pokemon_type).not_to be_valid
  end
end

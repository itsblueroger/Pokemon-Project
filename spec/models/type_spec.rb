require 'rails_helper'

RSpec.describe Type, type: :model do
  it "has a valid factory" do
    type = Type.create(name: "electric")
    expect(type).to be_valid
  end

  it "is invalid without a name" do
    type = Type.new(name: nil)
    expect(type).not_to be_valid
  end

  it "can have many pokemons" do
    type = Type.create(name: "electric")
    pokemon1 = Pokemon.create(name: "Pikachu")
    pokemon2 = Pokemon.create(name: "Raichu")
    type.pokemons << [pokemon1, pokemon2]

    expect(type.pokemons.size).to eq(2)
  end
end
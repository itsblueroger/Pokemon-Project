require 'rails_helper'

RSpec.describe Pokemon, type: :model do
  it "has a valid factory" do
    pokemon = Pokemon.create(name: "Pikachu")
    expect(pokemon).to be_valid
  end

  it "is invalid without a name" do
    pokemon = Pokemon.new(name: nil)
    expect(pokemon).not_to be_valid
  end

  it "can have many types" do
    pokemon = Pokemon.create(name: "Pikachu")
    type1 = Type.create(name: "electric")
    type2 = Type.create(name: "fairy")
    pokemon.types << [type1, type2]

    expect(pokemon.types.size).to eq(2)
  end
end
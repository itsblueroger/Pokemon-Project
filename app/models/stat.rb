class Stat < ApplicationRecord
  has_many :pokemon_stats
  has_many :pokemons, through: :pokemon_stats

  validates :name, presence: true
end

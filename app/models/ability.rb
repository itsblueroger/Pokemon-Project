class Ability < ApplicationRecord
  has_many :pokemon_abilities
  has_many :pokemons, through: :pokemon_abilities

  validates :name, presence: true

  def name_for_view
    name.split('-').map(&:capitalize).join(' ')
  end
end

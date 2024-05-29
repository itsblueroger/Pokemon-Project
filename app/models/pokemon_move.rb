class PokemonMove < ApplicationRecord
  belongs_to :pokemon
  belongs_to :move

  validates :level, presence: true

  def name_for_view
    move.name.split('-').map(&:capitalize).join(' ')
  end
end

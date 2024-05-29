class PokemonStat < ApplicationRecord
  belongs_to :pokemon
  belongs_to :stat

  validates :value, presence: true

  def name_for_view
    stat.name.split('-').map(&:capitalize).join(' ')
  end
end

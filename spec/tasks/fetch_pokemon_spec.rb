require 'rails_helper'
require 'rake'

describe 'pokemon:update_list' do
  let(:rake_task) do
    Rake.application.tap do |app|
      app.load_rakefile
    end
  end

  it 'calls the update_pokemons method of PokemonUpdaterService' do
    expect_any_instance_of(PokemonUpdaterService).to receive(:update_pokemons)
    rake_task['pokemon:update_list'].invoke
  end
end

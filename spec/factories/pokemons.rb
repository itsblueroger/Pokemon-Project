FactoryBot.define do
  factory :pokemon do
    name { "Pikachu" }
    game_id { 25 }
  end

  factory :move do
    name { "Thunderbolt" }
  end

  factory :pokemon_move do
    association :pokemon
    association :move
    level { 1 }
  end
end

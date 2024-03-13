FactoryBot.define do
  factory :game do
    game_log
    checksum { 'Checksum' }
  end
end

class ImportGameActivitiesService
  def self.call(game_id, game_data, content_parser)
    new(game_id, game_data, content_parser).call
  end

  def initialize(game_id, game_data, content_parser)
    @game_id = game_id
    @game_data = game_data
    @content_parser = content_parser
  end

  def call
    kills = @content_parser.kills(@game_data)
    kills.each do |kill_data|
      parsed_kill = @content_parser.parse_kill(@game_id, kill_data)
      killer = find_or_create_killer(parsed_kill[:killer], parsed_kill[:killer_type])
      killed = Player.find_or_create_by(name: parsed_kill[:killed])
      death_means = GameActivity::DEATH_MEANS.index(parsed_kill[:death_means])
      update_or_create_game_activity(parsed_kill[:kill_id], killer, killed, death_means)
    end
  end
  
  private
  def update_or_create_game_activity(kill_id, killer, killed, death_means)
    game_activity = GameActivity.find_by(game_id: @game_id, checksum: kill_id)
    if game_activity
      game_activity.update(killerable: killer, killed: killed, death_means: death_means)
    else
      GameActivity.create(game_id: @game_id, killerable: killer, killed: killed, death_means: death_means, checksum: kill_id)
    end
  end

  def find_or_create_killer(killer, killer_type)
    klass = killer_type == :world ? WorldEnvironment : Player
    klass.find_or_create_by(name: killer)
  end
end
class ImportGameLogService
  def self.call(log_data, adapter = TxtParser)
    game_log = GameLog.find_or_create_by(filename: log_data.original_filename)
    return false unless game_log
    
    game_log.file.attach(log_data)
    new(game_log.id, adapter).call
  end

  def initialize(game_log_id, adapter)
    @game_log_id = game_log_id
    @adapter = adapter
  end

  def call
    games = parser.games
    games.each do |game_data|
      game_id = parser.game_id(game_log.id, game_data)
      game = Game.find_or_create_by(game_log_id: game_log.id, checksum: game_id)
      kills = parser.kills(game_data)
      kills.each do |kill_data|
        parsed_kill = parser.parse_kill(game.id, kill_data)
        killer = parsed_kill[:killer_class].find_or_create_by(name: parsed_kill[:killer])
        killed = Player.find_or_create_by(name: parsed_kill[:killed])
        game_activity = GameActivity.find_by(game: game, checksum: parsed_kill[:kill_id])
        death_means = GameActivity::DEATH_MEANS.index(parsed_kill[:death_means])
        puts parsed_kill[:death_means]
        if game_activity
          game_activity.update(killerable: killer, killed: killed, death_means: death_means)
        else
          GameActivity.create(game: game, killerable: killer, killed: killed, death_means: death_means, checksum: parsed_kill[:kill_id])
        end
      end
    end
  end

  private

  def game_log
    @game_log ||= GameLog.find_by(id: @game_log_id)
  end

  def parser
    @parser = @adapter.new(game_log.file_path)
  end
end
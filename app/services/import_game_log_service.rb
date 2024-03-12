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
    end
  end

  private

  def game_log
    @game_log ||= GameLog.find(@game_log_id)
  end

  def parser
    @parser = @adapter.new(game_log.file_path)
  end
end
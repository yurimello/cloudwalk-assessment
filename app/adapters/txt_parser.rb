class TxtParser < BaseParser
  GAME_DELIMITATOR = /ShutdownGame/i
  
  def games
    @games ||= log_content.split(GAME_DELIMITATOR)
  end

  def game_id(game_log_id, content)
    game_data = content.match(/\n.*InitGame.*\n/i).to_s
    digest("#{game_log_id}#{game_data}")
  end

  private
  def log_content
    @log_content ||= File.read(@file_path)
  end

  def digest(content)
    Digest::SHA256.hexdigest(content)
  end
end
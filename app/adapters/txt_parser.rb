class TxtParser < BaseParser
  GAME_DELIMITATOR = /ShutdownGame/i
  
  def games
    @games ||= log_content.split(GAME_DELIMITATOR)
  end

  def game_id(game_log_id, content)
    game_data = content.match(/\n.*InitGame.*\n/i).to_s
    digest("#{game_log_id}#{game_data}")
  end

  def kills(game_data)
    game_data.split("\n").grep(/Kill/)
  end

  def parse_kill(game_id, kill_data)
    parsed_data = kill_data.match(/.*Kill:.*:\s(.*)\bkilled\b(.*)\bby\b(.*)/i)
    {
      killer: killer(parsed_data[1]),
      killer_class: killer_class(parsed_data[1]),
      killed: killed(parsed_data[2]),
      death_means: death_means(parsed_data[3]),
      kill_id: digest("#{game_id}#{kill_data}")
    }
  end

  private
  def killed(kill_data)
    kill_data.strip
  end

  def death_means(kill_data)
    kill_data.strip
  end

  def killer(kill_data)
    kill_data.gsub(/(\<|\>)/, '').strip
  end

  def killer_class(kill_data)
    kill_data.match(/world/) ? WorldEnvironment : Player
  end

  def log_content
    @log_content ||= File.read(@file_path)
  end

  def digest(content)
    Digest::SHA256.hexdigest(content)
  end
end
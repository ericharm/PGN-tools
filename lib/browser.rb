class Browser

    attr_accessor :entries, :active, :console, :current, :window

    def initialize(window)
      @window = window
      pgn_dir = get_pgn_dir
      @entries = []
      @active = 0
      Dir.chdir(pgn_dir)
      @current = pgn_dir
      @entries = Dir.entries('.')
    end

    def set_current(int)
      if File.directory?(@entries[@active])
        new_dir = @entries[int]
        Dir.chdir(new_dir)
        @current = new_dir
        @entries = Dir.entries('.')
        @active = 0
      end
    end

    def get_pgn_dir
      if File.exists?('pgn_dir.txt')
        pgn_dir = File.open('pgn_dir.txt', 'r').gets.chomp
        return pgn_dir
      else
        return create_pgn_dir
      end
    end

    def create_pgn_dir
      window.addstr "No PGN directory found.  Where do you keep your .pgn files? "
      window.refresh
      pgn_dir = @window.getstr
      pgn_txt = File.new('pgn_dir.txt', 'w')
      pgn_txt.print pgn_dir
      pgn_txt.close
      return pgn_dir
    end

end
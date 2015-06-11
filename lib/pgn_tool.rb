class PgnTool

  attr_accessor :pgns, :database

  def initialize(file_name)
    @pgns = get_pgns
    @database = File.new(file_name, 'w')
    combine_pgns(file_name)
  end

  def get_pgns
    pgn_files = []
    Dir.foreach('.') do |file|
      if file[-4..-1].eql?('.pgn')
        pgn_files << file
      end
    end
    return pgn_files
  end

  def combine_pgns(name)
    @pgns.each do |pgn|
      file = File.open(pgn, 'r')
      file.each_line do |line|
        @database.puts line
      end
    end
    @database.close
  end

end
class Browser

    attr_accessor :entries, :active, :console, :current

    def initialize
        @entries = []
        @active = 0
        Dir.chdir(PGN_DIR)
        @current = PGN_DIR
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

end
#!/usr/local/bin/ruby

require 'browser'
require 'pgn_tool'
require 'curses'
include Curses

class Menu

  attr_reader :window, :console, :height, :width, :browser

  def initialize(options)
    @window = options[:window]
    @console = options[:console]
    @height = options[:height]
    @width = options[:width]
    setup_curses
    @browser = Browser.new(@window)
    update
  end

  def setup_curses
    init_screen
    start_color
    curs_set(0)
    crmode
    nonl
    @console.keypad(true)
    init_pair(COLOR_WHITE,COLOR_WHITE,COLOR_BLACK)
    init_pair(COLOR_YELLOW,COLOR_YELLOW,COLOR_BLUE)
  end

  def update
    @window.clear
    @console.clear
    display_menu
    display_console
    input = @console.getch
    do_action(input)
  end

  def display_menu
    print_to_window(@window, @browser.current)
    @browser.entries.each_with_index do |entry, i|
      if i == @browser.active
        @window.attron(color_pair(COLOR_YELLOW)|A_BOLD){
        print_to_window(@window, entry, 2, i + 2) }
      else
        @window.attron(color_pair(COLOR_WHITE)|A_NORMAL){
        print_to_window(@window, entry, 2, i + 2) }
      end
    end
  end

  def display_console
    print_to_window(@console, "Arrows/Enter to nav, Q to quit, M to create db")
    print_to_window(@console, " > ", 1, 2)
  end


  def do_action(input)
    case input
    when KEY_UP
      @browser.active -= 1 unless @browser.active == 0
    when KEY_DOWN
      @browser.active += 1 unless @browser.active == @browser.entries.length - 1
    when 13
      @browser.set_current(@browser.active)
    when 'm'
      make_new_database
    when 'q'
      print_to_window(@console, 'QUIT')
    end
    update unless input == 'q'
  end

  def make_new_database
    @console.clear
    print_to_window(@console, "Name for new database: ")
    @console.setpos(4, 3)
    @console.refresh
    db_name = @console.getstr
    print_to_window(@console, "New database will be called #{db_name}")
    PgnTool.new(db_name)
    print_to_window(@console, "New database created")
    @console.getch
  end

  def print_to_window(window, text, x = 1, y = 1)
    window.setpos(y,x)
    window.addstr(text)
    window.refresh
  end

end
APP_ROOT = File.dirname(__FILE__)

$:.unshift(File.join(APP_ROOT,'lib'))

require 'menu'

HEIGHT = 18
WIDTH = 50

WINDOW_HEIGHT = HEIGHT - 1
WINDOW_WIDTH =  WIDTH - 1

CONSOLE_HEIGHT = 4
CONSOLE_Y = HEIGHT + 1

setup = { 
          window: Window.new(HEIGHT,WIDTH,2,2),
          console: Window.new(CONSOLE_HEIGHT,WIDTH,CONSOLE_Y,2),
          height: WINDOW_HEIGHT,
          width: WINDOW_WIDTH }

setup[:window].setpos(1,1)
setup[:console].setpos(1,1)

menu = Menu.new(setup)
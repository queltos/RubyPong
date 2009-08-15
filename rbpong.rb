#! /usr/bin/env ruby

require "rubygems"
require "rubygame"
require "lib/controller.rb"
require "lib/setup.rb"
require "lib/ball.rb"
#require "lib/game_object.rb"

include Rubygame

#TTF.setup is necessary for using and manipulating texts and fonts.
TTF.setup

setup = Setup.new
setup.run

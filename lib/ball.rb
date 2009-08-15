require "lib/game_object.rb"

class Ball < GameObject
  IMAGE = "data/ball.png"
  def initialize
    super(IMAGE)
  end
end

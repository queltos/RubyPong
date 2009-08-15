class GameObject
  attr_accessor :rect
  include Rubygame::Sprites::Sprite
  def initialize filename
#    super
    @image = Surface.load(filename)
    @rect = Rect.new(0,0,@image.size)
  end
end

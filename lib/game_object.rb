class GameObject
  attr_accessor :rect
  include Rubygame::Sprites::Sprite
  def initialize filename
    super()
    @image = Surface.load(filename)
    @rect = Rect.new(50,50,@image.size)
  end
end

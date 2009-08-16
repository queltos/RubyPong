class Controller
  include Rubygame::EventHandler::HasEventHandler
  include Rubygame::EventTriggers
  include Rubygame::EventActions

  # Signals sprites to draw themselves on the screen
  class DrawSprites
    attr_accessor :screen
    def initialize( screen )
      @screen = screen
    end
  end

  # Signals sprites to erase themselves from the screen
  class UndrawSprites
    attr_accessor :screen, :background
    def initialize( screen, background )
      @screen, @background = screen, background
    end
  end


  def initialize screen
    @screen = screen
    @queue = Rubygame::EventQueue.new
    @queue.enable_new_style_events
    @clock = Rubygame::Clock.new
    @clock.target_framerate = 30
    @background = Surface.load("data/playfield.png")

    # initialize objects
    @ball = Ball.new
    @objects = Sprites::Group.new
    @objects.extend(Sprites::UpdateGroup)
    @objects.push(@ball)
    
    class << @objects
      include EventHandler::HasEventHandler

      def do_draw(event)
        dirty_rects = draw(event.screen)
	event.screen.update_rects(dirty_rects)
      end
      
      def do_undraw(event)
        undraw(event.screen, event.background)
      end
    end

    @objects.make_magic_hooks(	:tick	      => :update,
    				DrawSprites   => :do_draw,
				UndrawSprites => :do_undraw )
  end
  
  def update
    puts "blub";
  end

  def hook_quit
    quit_hooks = {
      :escape => :quit,
      Rubygame::Events::QuitRequested => :quit
    }
    make_magic_hooks(quit_hooks)
  end
  def fps_update
    @screen.title = "FPS: #{@clock.framerate}"
  end
  def run
    hook_quit
    loop do
      @queue << UndrawSprites.new(@screen, @background)
      @queue << DrawSprites.new(@screen)
      @queue.each do |event|
        handle(event)
      end
      fps_update
      draw
      @screen.flip
      @clock.tick
    end
  end
  def quit
    Rubygame.quit
    exit
  end
  def draw
    @background.blit(@screen,[0,0])
  end
end


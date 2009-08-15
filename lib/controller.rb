class Controller
  include Rubygame::EventHandler::HasEventHandler
  def initialize screen
    @screen = screen
    @queue = Rubygame::EventQueue.new
    @queue.enable_new_style_events
    @clock = Rubygame::Clock.new
    @clock.target_framerate = 30
    @background = Surface.load("data/playfield.png")

    @ball = Ball.new
    os = Sprites::Group.new
    os.extend(Sprites::UpdateGroup)
    os.push(@ball)
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


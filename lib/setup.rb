class Setup
  include Rubygame::EventHandler::HasEventHandler
  def initialize
    @screen = Screen.new([800,600],0,[Rubygame::HWSURFACE,Rubygame::DOUBLEBUF])
    @queue = Rubygame::EventQueue.new
    @queue.enable_new_style_events
    @control = Controller.new(@screen)
    @background = Rubygame::Surface.load("data/titlescreen.png")
  end

  def quit
    Rubygame.quit
    exit
  end

  def hook_quit
    quit_hooks = {
      :escape => :quit,
      Rubygame::Events::QuitRequested => :quit,
    }
    make_magic_hooks(quit_hooks)
  end

  def run
    hook_quit
    hook_run
    loop do
      @queue.each do |event|
        handle(event)
      end
      draw
      @screen.flip
    end
  end

  def execute
    @control.run
  end

  def hook_run
    run_hook = {
      :return => :execute
    }
    make_magic_hooks(run_hook)
  end

  def draw
    @background.blit(@screen,[0,0])
  end
end

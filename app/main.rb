require "app/scene_title.rb"
require "app/scene_main.rb"
require "app/scene_about.rb"

def tick(args)
  args.state.current_scene ||= :Title
  
  case args.state.current_scene
  when :Title
    title_scene(args)
  when :Main
    main_scene(args)
  # when :About
  #   about_scene(args)
  end
end


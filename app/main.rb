require "app/scene_title.rb"
require "app/scene_main.rb"

def tick(args)
  args.state.current_scene ||= "Title"
  
  case args.state.current_scene
  when "Title"
    title_scene(args)
  when "Main"
    main_scene(args)
  end
end


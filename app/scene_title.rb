require "app/utils.rb"

TITLE_TEXT = { 
  x: 640, 
  y: 570, 
  text: "Plantiful",
  alignment_enum: 1,
  size_enum: 64,
  font: "fonts/Mansalva-Regular.ttf",
}

START_BUTTON = {
  x: 640,
  y: 430,
  text: "Start",
  alignment_enum: 1,
  size_enum: 18,
  font: "fonts/Mansalva-Regular.ttf",
  a: 255,
}

def title_scene args 
  args.state.initialized ||= false

  if !args.state.initialized
    puts "INITIALIZED"
    args.state.initialized = true
  end

  startbox = get_label_bounding_box(args, START_BUTTON)
  startbox_hovered = args.inputs.mouse.inside_rect?(startbox)

  if startbox_hovered
    START_BUTTON.a = 128
  else
    START_BUTTON.a = 255
  end

  if args.inputs.mouse.click and startbox_hovered
    args.state.current_scene = :Main
  end

  args.outputs.labels << TITLE_TEXT
  args.outputs.labels << START_BUTTON
end
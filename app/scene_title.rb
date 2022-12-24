require "app/utils.rb"

LOGO = {
  x: 640 - 200/2,
  y: 450,
  w: 200,
  h: 200,
  path: "sprites/logo.png"
}

TITLE_TEXT = { 
  x: 640, 
  y: 470, 
  text: "Plantiful",
  alignment_enum: 1,
  size_enum: 64,
  font: "fonts/Mansalva-Regular.ttf",
}

START_BUTTON = {
  x: 640,
  y: TITLE_TEXT.y - 140,
  text: "Start",
  alignment_enum: 1,
  size_enum: 18,
  font: "fonts/Mansalva-Regular.ttf",
  a: 255,
}

ABOUT_BUTTON = START_BUTTON.merge({
  text: "About",
  y: START_BUTTON.y - 60,
})

QUIT_BUTTON = START_BUTTON.merge({
  text: "Quit",
  y: START_BUTTON.y - 60,
})

def title_scene args 
  create_button(args, START_BUTTON) do
    args.state.current_scene = :Main
  end

  # create_button(args, ABOUT_BUTTON) do
  #   args.state.current_scene = :About
  # end

  create_button(args, QUIT_BUTTON) do
    exit
  end

  args.outputs.labels << TITLE_TEXT
  args.outputs.sprites << LOGO
end
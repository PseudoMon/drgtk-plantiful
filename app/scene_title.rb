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

# Currently unused
# ABOUT_BUTTON = START_BUTTON.merge({
#   text: "About",
#   y: START_BUTTON.y - 60,
# })

ABOUT_TEXT = {
  x: 640,
  y: 120,
  text: "Made by PseudoMon and miasmig",
  alignment_enum: 1,
  size_enum: 10,
  font: "fonts/Mansalva-Regular.ttf",
}

URL_TEXT = {
  x: 640,
  y: 70,
  text: "https://github.com/PseudoMon/drgtk-plantiful",
  alignment_enum: 1,
  size_enum: 6,
  font: "fonts/Mansalva-Regular.ttf",
}

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
  args.outputs.labels << ABOUT_TEXT
  args.outputs.labels << URL_TEXT
end
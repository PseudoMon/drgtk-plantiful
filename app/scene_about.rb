# Currently unused

TITLE = {
  x: 100,
  y: 620,
  text: "About",
  alignment_enum: 0,
  size_enum: 18,
  font: "fonts/Mansalva-Regular.ttf",
  a: 255,
}

def about_scene args
  args.outputs.labels << TITLE

  long_string = "Hi! Thanks for trying out this game! Plantiful was made in two days as a way to try out the DragonRuby GTK."
  max_character_length = 56
  long_strings_split = args.string.wrapped_lines long_string, max_character_length
  args.outputs.labels << long_strings_split.map_with_index do |s, i|
    { 
      x: 100, 
      y: 560 - (i * 24), 
      text: s,  
      font: "fonts/Lato-Regular.ttf",
    }
  end
end
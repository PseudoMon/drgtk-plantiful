require "app/utils.rb"

def create_watering_can args
  template = WATERING_CAN
  is_paused = args.state.is_paused
  hovered = args.inputs.mouse.inside_rect?(template)

  if hovered and not is_paused
    template = template.merge({ y: template.y + 20 })
  end

  if hovered and args.inputs.mouse.click and not is_paused
    cursor_state = args.state.cursor_state
    
    if cursor_state == :watering
      args.state.cursor_state = :nothing
    else
      args.state.cursor_state = :watering
    end
  end

  # When we're holding the watering can, 
  # don't show it in the usual spot
  if args.state.cursor_state != :watering
    args.outputs.sprites << template
  end
  
end

def create_seed_bag args
  template = SEED_BAG
  is_paused = args.state.is_paused
  hovered = args.inputs.mouse.inside_rect?(template)

  if hovered and not is_paused
    template = template.merge({ y: template.y + 20 })
  end

  if hovered and args.inputs.mouse.click and not is_paused
    cursor_state = args.state.cursor_state

    if cursor_state == :seeding
      args.state.cursor_state = :nothing
    else
      args.state.cursor_state = :seeding
    end
  end

  if args.state.cursor_state != :seeding
    args.outputs.sprites << template
  end
end

def create_count_machine args
  score = args.state.score
  args.outputs.labels << COUNT_LABEL.merge({ text: "#{score}" })
  args.outputs.sprites << COUNT_MACHINE

end

# Currently unused
def create_reset_button args
  reset_button = BOTTOM_LEFT_BUTTON.merge({ text: "Reset" })

  create_button(args, reset_button) do
    pots = args.state.pots
    pots.each do |pot|
      pot.remove_plant
    end
  end
end

def create_pause_button args
  text = args.state.is_paused ? "Continue" : "Pause"
  pause_button = BOTTOM_LEFT_BUTTON.merge({ text: text })

  create_button(args, pause_button) do
    args.state.is_paused = !args.state.is_paused
  end
end

def create_pots ondead
  pots = []
  4.times do |idx|
    pot = Pot.new(POT, PLANT_TEMPLATES, POT_HOVER, HAND_ICON)
    pot.place_on_shelf(SHELF_TOP, idx)
    pot.ondead = ondead
    pots << pot
  end

  4.times do |idx|
    pot = Pot.new(POT, PLANT_TEMPLATES, POT_HOVER, HAND_ICON)
    pot.place_on_shelf(SHELF_BOTTOM, idx)
    pot.ondead = ondead
    pots << pot
  end

  return pots
end

def create_watering_mouse args
  if args.state.cursor_state != :watering
    return
  end

  watering_mouse = WATERING_CAN.merge({
    x: args.inputs.mouse.x,
    y: args.inputs.mouse.y - 50,
    angle: 30,
  })

  args.outputs.sprites << watering_mouse
end

def create_seeding_mouse args
  if args.state.cursor_state != :seeding
    return
  end

  seeding_mouse = SEED_BAG.merge({
    x: args.inputs.mouse.x - 32,
    y: args.inputs.mouse.y - 30,
  })

  args.outputs.sprites << seeding_mouse
end
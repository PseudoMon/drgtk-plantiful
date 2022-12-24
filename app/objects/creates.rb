def create_watering_can args
  template = WATERING_CAN
  hovered = args.inputs.mouse.inside_rect?(template)

  if hovered and args.inputs.mouse.click
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
  hovered = args.inputs.mouse.inside_rect?(template)

  if hovered and args.inputs.mouse.click
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

def create_reset_button args
  boundbox = get_label_bounding_box(args, RESET_BUTTON)
  boundbox_hovered = args.inputs.mouse.inside_rect?(boundbox) 

  if boundbox_hovered
    RESET_BUTTON.a = 120
  else
    RESET_BUTTON.a = 255
  end

  if boundbox_hovered and args.inputs.mouse.click
    pots = args.state.pots
    pots.each do |pot|
      pot.remove_plant
    end
  end

  args.outputs.labels << RESET_BUTTON
end

def create_pots 
  pots = []
  4.times do |idx|
    pot = Pot.new(POT, PLANT_TEMPLATES)
    pot.place_on_shelf(SHELF_TOP, idx)
    pots << pot
  end

  4.times do |idx|
    pot = Pot.new(POT, PLANT_TEMPLATES)
    pot.place_on_shelf(SHELF_BOTTOM, idx)
    pots << pot
  end

  return pots
end

def create_watering_mouse args
  if args.state.cursor_state != :watering
    return
  end

  watering_mouse = WATERING_CAN.merge({
    x: args.inputs.mouse.x - 32,
    y: args.inputs.mouse.y - 20,
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
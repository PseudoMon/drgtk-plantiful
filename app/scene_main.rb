require "app/utils.rb"
require "app/objects/templates.rb"
require "app/objects/Pot.rb"

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

  if args.state.cursor_state != :watering
    # When we're holding the watering can, 
    # don't show it in the usual spot
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

def handle_pots_interaction args
  pots = args.state.pots
  
  pots.each do |pot|
    if pot.mouse_over? args

      case args.state.cursor_state
      when :watering
        if pot.is_there_plant?
          pot.grow_plant
        end

      when :nothing
        if pot.plant_is_fully_grown?
          pot.remove_plant
          args.state.score += 1
          add_score_popup(args)
        end

      when :seeding
        if !pot.is_there_plant?
          pot.grow_plant
        end
      end

    end
  end
end

def add_score_popup args
  args.state.scorepopups << { 
    x: args.inputs.mouse.x,
    y: args.inputs.mouse.y + 40,
    text: "+1",
    size_enum: 15,
    a: 255,
    font: "fonts/Mansalva-Regular.ttf",
  }
end

def main_scene args
  args.state.pots ||= create_pots()
  pots = args.state.pots

  args.state.cursor_state ||= :nothing
  args.state.score ||= 0
  args.state.scorepopups ||= []

  if args.inputs.mouse.click
    handle_pots_interaction(args)
  end
  
  # Render shelves
  args.outputs.sprites << get_centered_sprite(SHELF_TOP)
  args.outputs.sprites << get_centered_sprite(SHELF_BOTTOM)
  
  create_reset_button(args)
  create_count_machine(args)
  create_watering_can(args)
  create_seed_bag(args)

  # Render pots
  pots.each {|pot| args.outputs.sprites << pot.sprites }

  # Render and create mouse functionality
  create_watering_mouse(args)
  create_seeding_mouse(args)

  args.state.scorepopups.each do |score|
    args.outputs.labels << score
    score.a -= 10
    score.y += 1
    if score.a < 0 then score.a = 0 end
  end

  args.state.scorepopups.select! {|score| score.a > 0}
end

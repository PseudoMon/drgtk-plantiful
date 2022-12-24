require "app/utils.rb"
require "app/objects/templates.rb"
require "app/objects/Pot.rb"
require "app/objects/creates.rb"

def handle_pots_interaction args
  pots = args.state.pots
  
  pots.each do |pot|
    if pot.mouse_over? args

      case args.state.cursor_state
      when :watering
        if pot.is_there_plant?
          pot.reset_wilting_status
        end

      when :nothing
        if pot.is_plant_fully_grown?
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

def handle_pots_hovering args
  args.state.pots.each do |pot|
    if pot.mouse_over? args
      pot.hover
    else
      pot.unhover
    end
  end
end

def add_score_popup args
  args.state.scorepopups << { 
    x: args.inputs.mouse.x,
    y: args.inputs.mouse.y + 40,
    text: "+1",
    size_enum: 24,
    r: 106,
    g: 165,
    b: 58,
    a: 255,
    font: "fonts/Mansalva-Regular.ttf",
  }
end

def add_frowny_popup args, x, y
  args.state.scorepopups << {
    x: x + POT.w / 2,
    y: y + POT.h / 2 + 20,
    text: ":(",
    size_enum: 24,
    r: 255,
    g: 50,
    b: 50,
    a: 255,
    angle: 90,
    font: "fonts/Mansalva-Regular.ttf",
  }
end

def show_pause args
  args.outputs.labels << PAUSE_TEXT
end

def main_scene args
  args.state.pots ||= create_pots(proc do |x, y| 
    add_frowny_popup(args, x, y)
  end)
  pots = args.state.pots

  args.state.cursor_state ||= :nothing
  args.state.score ||= 0
  args.state.scorepopups ||= []
  args.state.is_paused ||= false

  if args.inputs.mouse.click and not args.state.is_paused
    handle_pots_interaction(args)
  end

  handle_pots_hovering(args)
  
  # Render shelves
  args.outputs.sprites << get_centered_sprite(SHELF_TOP)
  args.outputs.sprites << get_centered_sprite(SHELF_BOTTOM)
  
  # Create and render various objects
  create_pause_button(args)
  create_count_machine(args)
  create_watering_can(args)
  create_seed_bag(args)

  if not args.state.is_paused
    pots.each {|pot| pot.tick}
  end

  # Render pots
  pots.each {|pot| args.outputs.sprites << pot.sprites }

  if not args.state.is_paused
    # Render icons that follow your mouse
    create_watering_mouse(args)
    create_seeding_mouse(args)
  end

  args.state.scorepopups.each do |score|
    args.outputs.labels << score
    score.a -= 10
    score.y += 1
    if score.a < 0 then score.a = 0 end
  end

  # Show pause indicator
  if args.state.is_paused
    show_pause(args)
  end

  # Remove scorepopups that has already disappeared
  args.state.scorepopups.select! {|score| score.a > 0}
end

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
  args.state.plopups << { 
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
  args.state.plopups << {
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

def clear_scene args
  args.state.pots = nil
  args.state.cursor_state = nil
  args.state.score = nil
  args.state.plopups = nil
  args.state.is_paused = nil
end

def show_pause args
  args.outputs.labels << PAUSE_TEXT
  create_button(args, RETURN_TO_MENU) do
    clear_scene(args)
    args.state.current_scene = :Title
  end
end
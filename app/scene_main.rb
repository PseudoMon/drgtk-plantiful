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
  
  # Create and render various objects
  create_reset_button(args)
  create_count_machine(args)
  create_watering_can(args)
  create_seed_bag(args)

  # Run these process on the pots every tick
  pots.each {|pot| pot.tick}
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

  # Remove scorepopups that has already disappeared
  args.state.scorepopups.select! {|score| score.a > 0}
end

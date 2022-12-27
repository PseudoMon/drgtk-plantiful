require "app/utils.rb"
require "app/objects/templates.rb"
require "app/objects/Pot.rb"
require "app/objects/creates.rb"
require "app/helpers_main.rb"

def main_scene args
  args.state.pots ||= create_pots(proc do |x, y| 
    add_frowny_popup(args, x, y)
  end)
  pots = args.state.pots

  args.state.cursor_state ||= :nothing
  args.state.score ||= 0
  args.state.plopups ||= []
  args.state.is_paused ||= false

  if args.inputs.mouse.click and not args.state.is_paused
    handle_pots_interaction(args)
  end

  if not args.state.is_paused
    handle_pots_hovering(args)
  end
  
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

  args.state.plopups.each do |score|
    args.outputs.labels << score
    score.a -= 10
    score.y += 1
    if score.a < 0 then score.a = 0 end
  end

  # Remove scorepopups that has already disappeared
  args.state.plopups.select! {|score| score.a > 0}

  # Show pause screen
  # Note that this needs to be at the bottom because it's
  # possible to run clear scene here
  if args.state.is_paused
    show_pause(args)
  end
end
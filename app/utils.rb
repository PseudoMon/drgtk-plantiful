def get_label_bounding_box args, labelhash
  alignment_enum = labelhash.key?(:alignment_enum) ? 
    labelhash.alignment_enum : 0

  w, h = args.gtk.calcstringbox(labelhash.text, labelhash.size_enum, labelhash.font)
  
  x = labelhash.x + 0
  case alignment_enum
  when 1 #centered
    x = labelhash.x - w/2
  when 2 #right-aligned
    x = labelhash.x - w
  end

  box = { 
    x: x,
    y: labelhash.y - h, 
    w: w, 
    h: h 
  }
  return box
end

def get_centered_sprite sprite, xcenter=true, ycenter=true
  # Return the same sprite, but with custom pivot
  return sprite.merge({
    x: xcenter ? sprite.x - sprite.w/2 : sprite.x,
    y: ycenter ? sprite.y - sprite.h/2 : sprite.y,
  })
end

def create_button args, template
  # Add a button to the screen, running 
  # a block on click, if block is given
  
  boundbox = get_label_bounding_box(args, template)
  boundbox_hovered = args.inputs.mouse.inside_rect?(boundbox) 
  label = {}.merge(template)

  if boundbox_hovered
    label.a = 120
  else
    label.a = 255
  end

  if boundbox_hovered and args.inputs.mouse.click
    yield if block_given?
  end

  args.outputs.labels << label
end
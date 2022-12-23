def get_label_bounding_box args, labelhash
  w, h = args.gtk.calcstringbox(labelhash.text, labelhash.size_enum, labelhash.font)
  box = { 
    x: labelhash.x - w/2, 
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
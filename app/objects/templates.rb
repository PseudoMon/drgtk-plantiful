BOTTOM_LEFT_BUTTON = { 
  x: 50, 
  y: 100, 
  text: "Reset",
  alignment_enum: 0,
  size_enum: 18,
  font: "fonts/Mansalva-Regular.ttf",
}

PAUSE_TEXT = { 
  x: 640, 
  y: 420, 
  text: "Paused",
  alignment_enum: 1,
  size_enum: 72,
  a: 125,
  font: "fonts/Mansalva-Regular.ttf",
}

SHELF = {
  path: "sprites/shelf.png",
  w: 825,
  h: 54,
}

POT = {
  path: "sprites/pot.png",
  w: 155,
  h: 258,
}

PLANT_TEMPLATES = []
5.times do |i| 
  PLANT_TEMPLATES << {
    path: "sprites/plant#{i + 1}.png", 
    w: POT.w, 
    h: POT.h
  }
end

SHELF_TOP = SHELF.merge({
  # Pivot center
  x: 640,
  y: 420,
})

SHELF_DISTANCE = 260

SHELF_BOTTOM = SHELF.merge({
  # Pivot center
  x: SHELF_TOP.x,
  y: SHELF_TOP.y - SHELF_DISTANCE,
})

WATERING_CAN = {
  path: "sprites/wateringcan.png",
  w: 174,
  h: 128,
  x: (SHELF_TOP.x - SHELF_TOP.w/2).floor,
  y: SHELF_TOP.y + 72,
}

COUNT_MACHINE = {
  path: "sprites/countmachine.png",
  w: 143,
  h: 90,
  x: (SHELF_TOP.x - SHELF_TOP.w/2).floor + 34,
  y: SHELF_TOP.y,
}

COUNT_LABEL = { 
  x: COUNT_MACHINE.x + 58, 
  y: COUNT_MACHINE.y + 64, 
  text: "000",
  a: 192,
  size_enum: 18,
  font: "fonts/Mansalva-Regular.ttf",
}

SEED_BAG = {
  path: "sprites/seedbag.png",
  w: 129,
  h: 121,
  x: (SHELF_BOTTOM.x - SHELF_BOTTOM.w/2).floor + 32,
  y: SHELF_BOTTOM.y,
}


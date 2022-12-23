class Pot
	@@bottommargin = 20
	@@leftmargin = 170
	@@potwidth = 155

	def initialize template, plant_templates=[], dirt_template=nil
		# template must be hash with { path, w, h }
		# plant_templates should be an array of hashes
		# dirt_tempalte isn't really used for now

		@template = template
		@dirt_template = dirt_template
		@plant_templates = plant_templates
		@max_growth = plant_templates.length

		@x = -template.w
		@y = -template.h
		@contains_dirt = true
		@plant_growth = 0
	end

	def place_on_shelf shelf, idx
		@x = shelf.x - shelf.w/2 + @@leftmargin + (@@potwidth * idx)
		@y = shelf.y - shelf.h/2 + @@bottommargin
	end

	def add_dirt
		contains_dirt = true
	end

	def grow_plant
		if (@plant_growth + 1 <= @max_growth)
			@plant_growth += 1
		end
	end

	def plant_growth=(val)
		@plant_growth = val
	end

	def remove_plant
		@plant_growth = 0
	end

	def plant_is_fully_grown?
		return @plant_growth >= @max_growth
	end

	def is_there_plant?
		return @plant_growth > 0
	end

	def sprite
		return @template.merge({ x: @x, y: @y }) 
	end

	def mouse_over? args
		return args.inputs.mouse.inside_rect?({ 
			x: @x, y: @y, 
			w: @template.w, h: @template.h
		})
	end

	def sprites
		sprites = [@template.merge({ x: @x, y: @y })]
		
		# If there's plant growth, also show the plant
		# Growth level 1 use image at index 0, hence why the - 1
		if @plant_growth > 0
			sprites += [
				@plant_templates[@plant_growth - 1].merge({ x: @x, y: @y })
			]
		end

		return sprites
	end
end
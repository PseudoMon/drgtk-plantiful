class Pot
	@@bottommargin = 20
	@@leftmargin = 170
	@@potwidth = 155

	# starting counter for each phase
	@@to_wilted_starts = [0, 9999, 8 * 60, 6 * 60, 255, 6 * 50]

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

		# Frames until plant will wilt and be removed
		@to_wilted = 255 

		# Coloration modifier
		@r = 255
		@b = 255
		@g = 255
	end

	def plant_growth
		return @plant_growth
	end

	def place_on_shelf shelf, idx
		@x = shelf.x - shelf.w/2 + @@leftmargin + (@@potwidth * idx)
		@y = shelf.y - shelf.h/2 + @@bottommargin
	end

	def reset_coloration
		@r = 255.0
		@g = 255.0
		@b = 255.0
	end

	def grow_plant
		# Limit growth to its maximum
		if (@plant_growth + 1 <= @max_growth)
			@plant_growth += 1

			@to_wilted = @@to_wilted_starts[@plant_growth]
			self.reset_coloration
		end
	end

	def remove_plant
		@plant_growth = 0
	end

	def is_plant_fully_grown?
		return @plant_growth >= @max_growth
	end

	def is_there_plant?
		return @plant_growth > 0
	end

	def mouse_over? args
		return args.inputs.mouse.inside_rect?({ 
			x: @x, y: @y, 
			w: @template.w, h: @template.h
		})
	end

	def wilt
		if not self.is_there_plant? then return end

		if @r > 0 then @r -= 0.25 end
		if @g > 0 then @g -= 1 end
		if @b > 0 then @b -= 0.5 end
		
		if @to_wilted > 0
			@to_wilted -= 1
		else
			self.remove_plant 
			# TODO seems this always run or smth, check
			# which process gets run in the order
			# atm we cant plant seed at all
		end
	end

	def pot_sprite
		return @template.merge({ x: @x, y: @y }) 
	end

	def plant_sprite
		# Growth level 1 use image at index 0, hence why the - 1
		return @plant_templates[@plant_growth - 1]
			.merge({ 
				x: @x, 
				y: @y, 
				r: @r.floor, 
				g: @g.floor, 
				b: @b.floor, 
			})
	end

	def sprites
		sprites = [self.pot_sprite]
		
		# If there's plant growth, also show the plant
		if @plant_growth > 0
			sprites += [self.plant_sprite]
		end

		return sprites
	end
end
class Pot
	@@bottommargin = 20
	@@leftmargin = 170
	@@potwidth = 155

	# starting counter for each phase
	@@to_wilted_starts = [0, 9999, 9 * 60, 7 * 60, 9 * 60, 10 * 50]

	@@to_growth_starts = [0, 5 * 60, 8 * 60, 12 * 60, 12 * 60, 0]

	def initialize template, plant_templates=[], hover_template={}, hand_template={}
		# template must be hash with { path, w, h }
		# plant_templates should be an array of hashes

		@template = template
		@hover_template = hover_template
		@plant_templates = plant_templates
		@hand_template = hand_template
		@max_growth = plant_templates.length

		@x = -template.w
		@y = -template.h
		@plant_growth = 0

		# Frames until plant will wilt and be removed
		@to_wilted = 255 

		# Coloration modifier
		@r = 255
		@b = 255
		@g = 255

		@is_hovered = true

		# This should be a proc 
		@ondead = nil

		@hand_y = 0 #TODO
		@hand_goingdown = true
	end

	def ondead=(value)
		@ondead = value 
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

			self.reset_growing_status
			self.reset_wilting_status	
		end
	end

	def reset_growing_status
		@to_growth = @@to_growth_starts[@plant_growth]
	end

	def reset_wilting_status
		@to_wilted = @@to_wilted_starts[@plant_growth]
		self.reset_coloration
	end

	def remove_plant
		@plant_growth = 0
	end

	def hover
		@is_hovered = true
	end

	def unhover
		@is_hovered = false
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

	def tick
		# These things happen to this pot every tick
		if self.is_there_plant?
			self.closer_to_wilted
			self.closer_to_growth
		end

		if @hand_goingdown
			@hand_y = @hand_y > -10 ? @hand_y - 1 : @hand_y
			if @hand_y <= -10 then @hand_goingdown = false end
		else
			@hand_y = @hand_y < 10 ? @hand_y + 1 : @hand_y
			if @hand_y >= 10 then @hand_goingdown = true end
		end
	end

	def closer_to_growth
		if @to_growth > 0
			@to_growth -= 1
		else
			self.grow_plant
		end
	end

	def closer_to_wilted
		if not self.is_there_plant? then return end

		if @r > 0 then @r -= 0.25 end
		if @g > 0 then @g -= 1 end
		if @b > 0 then @b -= 0.5 end
		
		if @to_wilted > 0
			@to_wilted -= 1
		else
			self.wilt
		end
	end

	def wilt
		self.remove_plant
		if @ondead
			@ondead.call(@x, @y)
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
		sprites = []

		# If hovered, also show hover indicator
		if @is_hovered
			sprites += [@hover_template.merge({ x: @x, y: @y })]
		end

		sprites += [self.pot_sprite]
		
		# If there's plant growth, also show the plant
		if @plant_growth > 0
			sprites += [self.plant_sprite]
		end

		if @plant_growth == @max_growth
			sprites += [@hand_template.merge({ x: @x + 80, y: @y + 200 + @hand_y })]
		end

		return sprites
	end
end
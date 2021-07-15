module CheckStatsInBattle
	class Show

		def show
			create_scene
			draw_information
			loop do
				break if @exit
				# Update
				update_ingame
				update_bg
				update_choose_bar
				draw_information
				# Input
				set_input
			end
		end

		def create_scene
			# Background
			create_sprite("bg", "Scene_#{@bg}", @viewport)
			# Name
			@pkmn.each_with_index { |pkmn, i|
				next if pkmn.nil?
				file  = "Choose"
				file += "_Trainer" if i.even?
				create_sprite("choose #{i}", file, @viewport)
				w = @sprites["choose #{i}"].bitmap.width
				h = @sprites["choose #{i}"].bitmap.height / 2
				set_src_wh_sprite("choose #{i}", w, h)
				y = i == @position ? h : 0
				set_src_xy_sprite("choose #{i}", 0, y)
				qw = i.even? ? @quant[:player] : @quant[:opponent]
				qw = 3 if qw > 3
				disx = (Graphics.width - qw * w) / (qw + 1)
				if disx <= 0
					disx = 0
					echoln "You need to redraw bitmap 'Choose' if you want distance between these bitmaps that is greater than 0"
				end
				qh = i.even? ? @quant[:player] : @quant[:opponent]
				qh = qh/3 == 0 ? 1 : qh/3 > 2 ? 2 : qh/3
				disy = (Graphics.height / 2 - qh * h) / (qh + 1)
				if disy <= 0
					disy = 0
					echoln "You need to redraw bitmap 'Choose' if you want distance between these bitmaps that is greater than 0"
				end
				x = disx + (disx + w) * ((i.even? ? i/2 : (i-1)/2) % 3)
				multiple = 0
				real = i.even? ? i/2 : (i-1)/2
				multiple = real / 3 if real > 3
				y = (i.even? ? Graphics.height/2 : 0) + disy + (disy + h) * multiple
				set_xy_sprite("choose #{i}", x, y)
			}
			# Text
			create_sprite_2("text", @viewport)
			@sprites["text"].z = 1
			# Icon
			@pkmn.each_with_index { |pkmn, i|
				next if pkmn.nil?
				species = pkmn.effects[PBEffects::Transform] ? pkmn.effects[PBEffects::TransformSpecies] : pkmn.species
      	species = GameData::Species.get(species).species
				pkmn = pkmn.effects[PBEffects::STORE_SPECIES] if pkmn.effects[PBEffects::Transform]
				file = GameData::Species.icon_bitmap(species, pkmn.form, pkmn.gender, pkmn.shiny?, pkmn.shadowPokemon?)
				@sprites["pkmn #{i}"] = file
			}
			["point", "increase", "decrease"].each { |i| @sprites[i] = Bitmap.new("Graphics/Pictures/Check stats/#{i.capitalize}") }
			["statuses", "types"].each { |i| @sprites[i] = Bitmap.new("Graphics/Pictures/#{i}") }
		end

		#-----------#
		# Draw text #
		#-----------#
		def draw_information
			clearTxt("text")
			text = []
			bitmap = @sprites["text"].bitmap
			stat = ["ATTACK", "DEFENSE", "SPECIAL_ATTACK", "SPECIAL_DEFENSE", "SPEED", "ACCURACY", "EVASION"]
			# String
			if @chose
				xystat = []
				# HP, Level and name
				stringhp = "HP: #{@pkmn[@position].hp}/#{@pkmn[@position].totalhp}"
				x = 64 + 5
				y = 30
				text << [stringhp, x, y, 0, Color.new(0,0,0), Color.new(255,255,255)]
				string = "#{@pkmn[@position].name}"
				x = 64 + 5
				y = 0
				text << [string, x, y, 0, Color.new(0,0,0), Color.new(255,255,255)]
				x = 64 + 5 + bitmap.text_size(string).width + 10
				string = "Lv.#{@pkmn[@position].level}"
				y = 0
				text << [string, x, y, 0, Color.new(0,0,0), Color.new(255,255,255)]
				# Check active field
				if @active != 0
					active = store_active
					active.each_with_index { |atv, i|
						string = atv
						x = i == 0 ? 5 : 10
						y = 64 + 30 * i
						text << [string, x, y, 0, Color.new(0,0,0), Color.new(255,255,255)]
					}
				else
					# Stats
					stat.each_with_index { |stat, i|
						string = 
							case stat
							when "ATTACK"          then "ATK" 
							when "DEFENSE"         then "DEF"
							when "SPECIAL_ATTACK"  then "SP.ATK"
							when "SPECIAL_DEFENSE" then "SP.DEF"
							when "ACCURACY"        then "ACC"
							when "EVASION"         then "EVA"
							else stat
							end
						x = 5 + (70 + 180) * (i.even? ? 0 : 1)
						y = 64 + 30 * (i / 2)
						text << [string, x, y, 0, Color.new(0,0,0), Color.new(255,255,255)]
						xystat << [x, y]
					}
					# Ability
					string = "Ability: " + "#{@pkmn[@position].ability_id}".capitalize
					x = xystat[stat.size-1][0]
					yabi = xystat[stat.size-1][1] + 40
					text << [string, x, yabi, 0, Color.new(0,0,0), Color.new(255,255,255)]
					description = GameData::Ability.try_get(@pkmn[@position].ability).real_description
					arr = split_text(description, 500)
					arr.each_with_index { |string, i|
						x = xystat[stat.size-1][0]
						y = yabi + 30 + 30 * i
						text << [string, x, y, 0, Color.new(0,0,0), Color.new(255,255,255)]
					}
				end
			else
				@pkmn.each_with_index { |pkmn, i|
					next if !@sprites["choose #{i}"] || pkmn.nil?
					string = "#{pkmn.name}"
					x = @sprites["choose #{i}"].x + 64 + 5
					y = @sprites["choose #{i}"].y
					text << [string, x, y, 0, Color.new(0,0,0), Color.new(255,255,255)]
				}
				@name.each_with_index { |name, i|
					next if !@sprites["choose #{i}"] || name.nil?
					string = "#{name}"
					x = @sprites["choose #{i}"].x + @sprites["choose #{i}"].src_rect.width - bitmap.text_size(string).width
					y = @sprites["choose #{i}"].y + @sprites["choose #{i}"].src_rect.height - 25
					text << [string, x, y, 0, Color.new(0,0,0), Color.new(255,255,255)]
				}
			end
			drawTxt("text", text)
			# Bitmap
			if @frames > 4
				@iconw += 64
				@iconw  = 0 if @iconw > 64
				@frames = 0
			end
			rect = Rect.new(@iconw, 0, 64, 64)
			if @chose
				bitmap.blt(0, 0, @sprites["pkmn #{@position}"], rect)
				if @active == 0
					# Stats
					stat.each_with_index { |stat, i|
						stage = @pkmn[@position].stages[stat.to_sym]
						rectnew = Rect.new(0, 0, 30, 30)
						if stage > 0
							file = @sprites["increase"]
							(stage.abs).times { |j|
								x = xystat[i][0] + 70 + 30 * j
								y = xystat[i][1] + 10
								bitmap.blt(x, y, file, rectnew)
							}
						elsif stage < 0
							file = @sprites["decrease"]
							(stage.abs).times { |j|
								x = xystat[i][0] + 70 + 30 * j
								y = xystat[i][1] + 10
								bitmap.blt(x, y, file, rectnew)
							}
						end
						minus = 6 - (stage.abs)
						next if minus <= 0
						file = @sprites["point"]
						minus.times { |j|
							x = xystat[i][0] + 70 + 30 * (6 - minus + j)
							y = xystat[i][1] + 10
							bitmap.blt(x, y, file, rectnew)
						}
					}
				end
				# Type
				x = (Graphics.width - 8) - @sprites["types"].width
				y = 5
				file = @sprites["types"]
				srcy = GameData::Type.get(@pkmn[@position].type1).id_number
				bitmap.blt(x, y, file, Rect.new(0, srcy * 28, 64, 28))
				if @pkmn[@position].type2 && @pkmn[@position].type2 != @pkmn[@position].type1
					x = (Graphics.width - 8) - @sprites["types"].width
					y += 28 + 5
					file = @sprites["types"]
					srcy = GameData::Type.get(@pkmn[@position].type2).id_number
					bitmap.blt(x, y, file, Rect.new(0, srcy * 28, 64, 28))
				end
				# Status
				x = 64 + 5 + bitmap.text_size(stringhp).width + 10
				y = 40
				file = @sprites["statuses"]
				srcy = GameData::Status.get(@pkmn[@position].status).id_number - 1
				bitmap.blt(x, y, file, Rect.new(0, srcy * 16, 44, 16))
			else
				@pkmn.each_with_index { |pkmn, i|
					next if pkmn.nil?
					x = @sprites["choose #{i}"].x
					y = @sprites["choose #{i}"].y
					bitmap.blt(x, y, @sprites["pkmn #{i}"], rect)
				}
			end
			@frames += 1
		end

		def split_text(text1, width)
			i = 0
			str = ""
			text2 = []
			length = text1.length
			real = length * 12
			# Use to define 'Space'
			space = 0
			first = true
			strfake = ""
			loop do
				break if i == text1.length
				if first
					if text1[i] == " "
						i += 1
						next
					end
					first = false
				end
				space += 1 if text1[i] == " "
				str << text1[i] if space < 1
				if space > 0
					strfake << text1[i]
					if space == 2 && i+1 != text1.length
						if (str.length + strfake.length) * 12 > width
							text2 << str
							str = strfake
						elsif (str.length + strfake.length) * 12 <= width
							str << strfake
						end
						strfake = ""
						space = 1
					elsif i+1 == text1.length
						text2 << (str + strfake)
					end
				else
					text2 << str if i+1 == text1.length
				end
				i += 1
			end
			return text2
		end

		#-------#
		# Input #
		#-------#
		def set_input
			@exit = true if checkInput(Input::BACK)
			if checkInput(Input::USE)
				# Set active
				change_active(false)
				# Increase page
				if @chose
					@active += 1
					@active  = 0 if @active > @showactive.size
				end
				@chose = true
			elsif checkInput(Input::LEFT)
				@position -= 2
				@position  = @position.even? ? (2 * (@quant[:player] - 1)) : (2 * (@quant[:opponent] - 1) + 1) if @position < 0
				# Set active
				change_active
			elsif checkInput(Input::RIGHT)
				@position += 2
				if @position >= @pkmn.size
					@position = @position.even? ? 0 : 1
				end
				# Set active
				change_active
			elsif checkInput(Input::UP)
				@position += 1
				if @position < @pkmn.size - 1
					@position += 1 if !@pkmn[@position]
				elsif @position >= @pkmn.size
					@position = 0
				end
				# Set active
				change_active
			elsif checkInput(Input::DOWN)
				@position -= 1
				if @position > 0
					@position -= 1 if !@pkmn[@position]
				elsif @position < 0
					@position = @pkmn.size - 1
				end
				# Set active
				change_active
			end
		end

		#--------#
		# Update #
		#--------#
			def update_bg
				return if !@chose
					if @chose
						@active == 0 ? (return if @bg == 2) : (return if @bg == 3)
					end
					@bg = @active == 0 ? 2 : 3
					set_sprite("bg", "Scene_#{@bg}")
				end

		def update_choose_bar
			if @chose
				@pkmn.each_with_index { |pkmn, i|
					next if pkmn.nil?
					set_visible_sprite("choose #{i}")
				}
				return
			end
			@pkmn.each_with_index { |pkmn, i|
				next if pkmn.nil?
				h = i == @position ? @sprites["choose #{i}"].src_rect.height : 0
				set_src_xy_sprite("choose #{i}", 0, h)
			}
		end

		#--------------#
		# Check active #
		#--------------#
		def store_active
			return if @active == 0
			active = []
			show = 
				case @showactive[@active-1]
				when @activef then @showactive[@active-1]
				when @actives then @showactive[@active-1][@position%2]
				when @activep then @showactive[@active-1][@position]
				end
			show.each { |k, v| active << "#{k}: #{v}" }
			width = 512
			active.each_with_index{ |line, i|
				length = line.length
				real   = length * 12
				rate   = real / width
				next if rate <= 0
				arrfake = split_text(line, width)
				arrfake.each_with_index { |fake, j| j == 0 ? (active[i] = fake) : (active.insert(i+1, fake)) }
			}
			if active.size > max_show_active
				@framesactive += 1
				if @framesactive > 2 ** 5
					@framesactive = 0
					@originactive += 1
					@originactive  = 0 if @originactive >= active.size
				end
				rest = @originactive + max_show_active - active.size if @originactive + max_show_active > active.size
				activefake = active[@originactive...(@originactive + max_show_active)]
				rest.times { |i| activefake << active[i] } if rest
				active = activefake
			end
			title = 
				case @showactive[@active-1]
				when @activef then "Active field:"
				when @actives then "Active side:"
				when @activep then "Active position:"
				end
			active.unshift(title)
			return active
		end

		def max_show_active = 9

		def change_active(rs=true)
			return unless @chose
			# Set
			set_active_size
			# Reset
			@active = 0 if rs
			@originactive = 0
			@framesactive = 0
		end

	end
end
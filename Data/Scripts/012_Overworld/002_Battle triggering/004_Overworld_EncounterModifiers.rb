################################################################################
# This section was created solely for you to put various bits of code that
# modify various wild Pokémon and trainers immediately prior to battling them.
# Be sure that any code you use here ONLY applies to the Pokémon/trainers you
# want it to apply to!
################################################################################

# Make all wild Pokémon shiny while a certain Switch is ON (see Settings).
Events.onWildPokemonCreate += proc { |_sender, e|
  pokemon = e[0]
  if $game_switches[Settings::SHINY_WILD_POKEMON_SWITCH]
    pokemon.shiny = true
  end
}

# Used in the random dungeon map.  Makes the levels of all wild Pokémon in that
# map depend on the levels of Pokémon in the player's party.
# This is a simple method, and can/should be modified to account for evolutions
# and other such details.  Of course, you don't HAVE to use this code.
Events.onWildPokemonCreate += proc { |_sender, e|
  pokemon = e[0]
  if $game_map.map_id == 51
    new_level = pbBalancedLevel($Trainer.party) - 4 + rand(5)   # For variety
    new_level = new_level.clamp(1, GameData::GrowthRate.max_level)
    pokemon.level = new_level
    pokemon.calc_stats
    pokemon.reset_moves
  end
}

Events.onWildPokemonCreate += proc { |_sender, e|
  pkmn = e[0]
  #Route 105 Move Generation
  if $game_map.map_id == 123
    if pkmn.isSpecies?(:EKANS)
		pkmn.forget_all_moves
		i = rand(4)
		case i
		when 1 
			pkmn.learn_move(:DISABLE)
		when 2 
			pkmn.learn_move(:LEER)
		when 3
			pkmn.learn_move(:POISONFANG)
		when 4
			pkmn.learn_move(:GLARE)
		end
		pkmn.learn_move(:ACID)
		pkmn.learn_move(:SCREECH)
		pkmn.learn_move(:BITE)
	end
	if pkmn.isSpecies?(:WATCHOG)
		pkmn.forget_all_moves
		i = rand(4)
		case i
		when 1 
			pkmn.learn_move(:ROTOTILLER)
		when 2 
			pkmn.learn_move(:CONFUSERAY)
		when 3
			pkmn.learn_move(:DETECT)
		when 4
			pkmn.learn_move(:HYPNOSIS)
		end
		pkmn.learn_move(:BIDE)
		pkmn.learn_move(:LOWKICK)
		pkmn.learn_move(:CRUNCH)
	end
	if pkmn.isSpecies?(:WEEPINBELL)
		pkmn.forget_all_moves
		i = rand(4)
		case i
		when 1 
			pkmn.learn_move(:SLEEPPOWDER)
		when 2 
			pkmn.learn_move(:POISONPOWDER)
		when 3
			pkmn.learn_move(:STUNSPORE)
		when 4
			pkmn.learn_move(:SYNTHESIS)
		end
		pkmn.learn_move(:GROWTH)
		pkmn.learn_move(:VINEWHIP)
		pkmn.learn_move(:SUNNYDAY)
	end
	if pkmn.isSpecies?(:LEDIAN)
		pkmn.forget_all_moves
		i = rand(4)
		case i
		when 1 
			pkmn.learn_move(:LIGHTSCREEN)
		when 2 
			pkmn.learn_move(:REFLECT)
		when 3
			pkmn.learn_move(:SUPERSONIC)
		when 4
			pkmn.learn_move(:SAFEGUARD)
		end
		pkmn.learn_move(:SWIFT)
		pkmn.learn_move(:MACHPUNCH)
		pkmn.learn_move(:SILVERWIND)
	end
  end
	#Shimmerwood Move Generation
  if $game_map.map_id == 104
	if pkmn.isSpecies?(:PIDGEY)
		pkmn.forget_all_moves
		pkmn.learn_move(:PURSUIT)
		pkmn.learn_move(:QUICKATTACK)
		pkmn.learn_move(:GUST)
		pkmn.learn_move(:SANDATTACK)
	end
	if pkmn.isSpecies?(:PIDGEOTTO)
		pkmn.forget_all_moves
		pkmn.learn_move(:PURSUIT)
		pkmn.learn_move(:QUICKATTACK)
		pkmn.learn_move(:GUST)
		pkmn.learn_move(:SANDATTACK)
	end
  end
}

# This is the basis of a trainer modifier. It works both for trainers loaded
# when you battle them, and for partner trainers when they are registered.
# Note that you can only modify a partner trainer's Pokémon, and not the trainer
# themselves nor their items this way, as those are generated from scratch
# before each battle.
#Events.onTrainerPartyLoad += proc { |_sender, trainer|
#  if trainer   # An NPCTrainer object containing party/items/lose text, etc.
#    YOUR CODE HERE
#  end
#}

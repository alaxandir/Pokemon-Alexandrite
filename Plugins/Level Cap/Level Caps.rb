#==============================================================================#
#\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\#
#==============================================================================#
#                                                                              #
#                        Simple Customizable Level Caps                        #
#                                     v1.0                                     #
#                               By Golisopod User							   #
#						 Edits for v19.1 by Aiur Jordan	                       #
#						 With lots of help from Vendily                        #
#		Amalgamated with ClaraDragon's Super Simple Level Caps Script          #
#           https://www.pokecommunity.com/showthread.php?t=452355              #
#==============================================================================#
#\\\\\\\\\\\\\\\\\\\\\\\\\\\HOW TO USE \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\#
#==============================================================================#
#                                                                              #
#                                                                              #							  
# This script uses a global called $PokemonSystem.difficulty and the level     #
# cap is only enforced when it is >= 2; to use your own setting replace all    #
# instances of $PokemonSystem.difficulty by using CTRL+F and replace           #
# with $game_variables[id] == X or $game_switches[id]                          #
#                                                                              #               
#==============================================================================#
#\\\\\\\\\\\\\\\\\\\\\\\\\\CONFIGURATION\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\#
#==============================================================================#
LEVEL_CAPS = [10,15,22,25,31,44,47,60,100] #scales according to gym badges
										   #The first value is 0 badges.
LEVEL_CAP_EXP = 2   #the exp gained if the levelcap is active change it if you 
                    #want to make the pokemon gain some exp, recomended less than 100
#==============================================================================#
# PASTE THIS def pbAddEXP into your Item_Utilities at the very bottom.         #
#==============================================================================#
=begin
def pbAddExp(pkmn,exp,scene)
  old_level = pkmn.level
  pkmn.exp = pkmn.growth_rate.add_exp(pkmn.exp,exp)
  level_diff = (pkmn.level+1) - old_level
  if exp>0
    pbMessage(_INTL("{1} gained {2} Experience Points.",pkmn.name,exp))
  else
    pbMessage(_INTL("{1} lost {2} Experience Points.",pkmn.name,exp))
  end
  if old_level>pkmn.level
    attackdiff  = pkmn.attack
    defensediff = pkmn.defense
    speeddiff   = pkmn.speed
    spatkdiff   = pkmn.spatk
    spdefdiff   = pkmn.spdef
    totalhpdiff = pkmn.totalhp
    pkmn.calc_stats
    scene.pbRefresh
    pbMessage(_INTL("{1} dropped to Lv. {2}!",pkmn.name,pkmn.level))
    attackdiff  = pkmn.attack-attackdiff
    defensediff = pkmn.defense-defensediff
    speeddiff   = pkmn.speed-speeddiff
    spatkdiff   = pkmn.spatk-spatkdiff
    spdefdiff   = pkmn.spdef-spdefdiff
    totalhpdiff = pkmn.totalhp-totalhpdiff
    pbTopRightWindow(_INTL("Max. HP<r>{1}\r\nAttack<r>{2}\r\nDefense<r>{3}\r\nSp. Atk<r>{4}\r\nSp. Def<r>{5}\r\nSpeed<r>{6}",
       totalhpdiff,attackdiff,defensediff,spatkdiff,spdefdiff,speeddiff))
    pbTopRightWindow(_INTL("Max. HP<r>{1}\r\nAttack<r>{2}\r\nDefense<r>{3}\r\nSp. Atk<r>{4}\r\nSp. Def<r>{5}\r\nSpeed<r>{6}",
       pkmn.totalhp,pkmn.attack,pkmn.defense,pkmn.spatk,pkmn.spdef,pkmn.speed))
  elsif old_level<pkmn.level
    attackdiff  = pkmn.attack
    defensediff = pkmn.defense
    speeddiff   = pkmn.speed
    spatkdiff   = pkmn.spatk
    spdefdiff   = pkmn.spdef
    totalhpdiff = pkmn.totalhp
    pkmn.changeHappiness("vitamin")
    pkmn.calc_stats
    scene.pbRefresh
    if scene.is_a?(PokemonPartyScreen)
      scene.pbDisplay(_INTL("{1} grew to Lv. {2}!",pkmn.name,pkmn.level))
    else
      pbMessage(_INTL("{1} grew to Lv. {2}!",pkmn.name,pkmn.level))
    end
    attackdiff  = pkmn.attack-attackdiff
    defensediff = pkmn.defense-defensediff
    speeddiff   = pkmn.speed-speeddiff
    spatkdiff   = pkmn.spatk-spatkdiff
    spdefdiff   = pkmn.spdef-spdefdiff
    totalhpdiff = pkmn.totalhp-totalhpdiff
    pbTopRightWindow(_INTL("Max. HP<r>+{1}\r\nAttack<r>+{2}\r\nDefense<r>+{3}\r\nSp. Atk<r>+{4}\r\nSp. Def<r>+{5}\r\nSpeed<r>+{6}",
       totalhpdiff,attackdiff,defensediff,spatkdiff,spdefdiff,speeddiff),scene)
    pbTopRightWindow(_INTL("Max. HP<r>{1}\r\nAttack<r>{2}\r\nDefense<r>{3}\r\nSp. Atk<r>{4}\r\nSp. Def<r>{5}\r\nSpeed<r>{6}",
       pkmn.totalhp,pkmn.attack,pkmn.defense,pkmn.spatk,pkmn.spdef,pkmn.speed),scene)
    # Learn new moves upon level up
    movelist = pkmn.getMoveList
    for i in movelist
      next if i[0]!=pkmn.level
      pbLearnMove(pkmn,i[1],true) { scene.pbUpdate }
    end
    # Check for evolution
    newspecies = pkmn.check_evolution_on_level_up
    if newspecies
      pbFadeOutInWithMusic {
        evo = PokemonEvolutionScene.new
        evo.pbStartScreen(pkmn,newspecies)
        evo.pbEvolution
        evo.pbEndScreen
        scene.pbRefresh if scene.is_a?(PokemonPartyScreen)
      }
	end
  end
end

=end

class PokeBattle_Battle
def pbGainExpOne(idxParty,defeatedBattler,numPartic,expShare,expAll,showMessages=true)
    pkmn = pbParty(0)[idxParty]   # The Pokémon gaining EVs from defeatedBattler
    growth_rate = pkmn.growth_rate
    # Don't bother calculating if gainer is already at max Exp
    if pkmn.exp>=growth_rate.maximum_exp
      pkmn.calc_stats   # To ensure new EVs still have an effect
      return
    end
    isPartic    = defeatedBattler.participants.include?(idxParty)
    hasExpShare = expShare.include?(idxParty)
    level = defeatedBattler.level
    # Main Exp calculation
    exp = 0
    a = level*defeatedBattler.pokemon.base_exp
    if expShare.length>0 && (isPartic || hasExpShare)
      if numPartic==0   # No participants, all Exp goes to Exp Share holders
        exp = a / (Settings::SPLIT_EXP_BETWEEN_GAINERS ? expShare.length : 1)
      elsif Settings::SPLIT_EXP_BETWEEN_GAINERS   # Gain from participating and/or Exp Share
        exp = a/(2*numPartic) if isPartic
        exp += a/(2*expShare.length) if hasExpShare
      else   # Gain from participating and/or Exp Share (Exp not split)
        exp = (isPartic) ? a : a/2
      end
    elsif isPartic   # Participated in battle, no Exp Shares held by anyone
      exp = a / (Settings::SPLIT_EXP_BETWEEN_GAINERS ? numPartic : 1)
    elsif expAll   # Didn't participate in battle, gaining Exp due to Exp All
      # NOTE: Exp All works like the Exp Share from Gen 6+, not like the Exp All
      #       from Gen 1, i.e. Exp isn't split between all Pokémon gaining it.
      exp = a/2
    end
    return if exp<=0
    # Pokémon gain more Exp from trainer battles
    exp = (exp*1.5).floor if trainerBattle?
    # Scale the gained Exp based on the gainer's level (or not)
    if Settings::SCALED_EXP_FORMULA
      exp /= 5
      levelAdjust = (2*level+10.0)/(pkmn.level+level+10.0)
      levelAdjust = levelAdjust**5
      levelAdjust = Math.sqrt(levelAdjust)
      exp *= levelAdjust
      exp = exp.floor
      exp += 1 if isPartic || hasExpShare
    else
      exp /= 7
    end
#========EXP CHANGING SCRIPT======================================================================#
    if defined?(pkmn) #check if the pkmn variable exist, for v18 and v19 compatibility
    	thispoke = pkmn
    end
    if $PokemonSystem.difficulty >= 2  #<- REPLACE WITH YOUR SETTING $game_variables[id] == X or $game_switches[id] 
		levelCap=LEVEL_CAPS[$Trainer.badge_count]
		exp=LEVEL_CAP_EXP if (thispoke.level >= levelCap) && exp>LEVEL_CAP_EXP
    else
		levelCap=GameData::GrowthRate.max_level
    end
#==================================================================================================#
    # Foreign Pokémon gain more Exp
    isOutsider = (pkmn.owner.id != pbPlayer.id ||
                 (pkmn.owner.language != 0 && pkmn.owner.language != pbPlayer.language))
    if isOutsider
      if pkmn.owner.language != 0 && pkmn.owner.language != pbPlayer.language
        exp = (exp*1.7).floor
      else
        exp = (exp*1.5).floor
      end
    end
    # Modify Exp gain based on pkmn's held item
    i = BattleHandlers.triggerExpGainModifierItem(pkmn.item,pkmn,exp)
    if i<0
      i = BattleHandlers.triggerExpGainModifierItem(@initialItems[0][idxParty],pkmn,exp)
    end
    exp = i if i>=0
    # Make sure Exp doesn't exceed the maximum
    expFinal = growth_rate.add_exp(pkmn.exp, exp)
    expGained = expFinal-pkmn.exp
    return if expGained<=0
    # "Exp gained" message
    if showMessages
      if isOutsider
        pbDisplayPaused(_INTL("{1} got a boosted {2} Exp. Points!",pkmn.name,expGained))
	  elsif exp>2
        pbDisplayPaused(_INTL("{1} got {2} Exp. Points!",pkmn.name,expGained))
	  else
	    pbDisplayPaused(_INTL("{1} got a meager {2} Exp. Points...",pkmn.name,expGained))
      end
    end
    curLevel = pkmn.level
    newLevel = growth_rate.level_from_exp(expFinal)
    if newLevel<curLevel
      debugInfo = "Levels: #{curLevel}->#{newLevel} | Exp: #{pkmn.exp}->#{expFinal} | gain: #{expGained}"
      raise RuntimeError.new(
         _INTL("{1}'s new level is less than its\r\ncurrent level, which shouldn't happen.\r\n[Debug: {2}]",
         pkmn.name,debugInfo))
    end
    # Give Exp
    if pkmn.shadowPokemon?
      pkmn.exp += expGained
      return
    end
    tempExp1 = pkmn.exp
    battler = pbFindBattler(idxParty)
    loop do   # For each level gained in turn...
      # EXP Bar animation
      levelMinExp = growth_rate.minimum_exp_for_level(curLevel)
      levelMaxExp = growth_rate.minimum_exp_for_level(curLevel + 1)
      tempExp2 = (levelMaxExp<expFinal) ? levelMaxExp : expFinal
      pkmn.exp = tempExp2
      @scene.pbEXPBar(battler,levelMinExp,levelMaxExp,tempExp1,tempExp2)
      tempExp1 = tempExp2
      curLevel += 1
      if curLevel>newLevel
        # Gained all the Exp now, end the animation
        pkmn.calc_stats
        battler.pbUpdate(false) if battler
        @scene.pbRefreshOne(battler.index) if battler
        break
      end
      # Levelled up
      pbCommonAnimation("LevelUp",battler) if battler
      oldTotalHP = pkmn.totalhp
      oldAttack  = pkmn.attack
      oldDefense = pkmn.defense
      oldSpAtk   = pkmn.spatk
      oldSpDef   = pkmn.spdef
      oldSpeed   = pkmn.speed
      if battler && battler.pokemon
        battler.pokemon.changeHappiness("levelup")
      end
      pkmn.calc_stats
      battler.pbUpdate(false) if battler
      @scene.pbRefreshOne(battler.index) if battler
      pbDisplayPaused(_INTL("{1} grew to Lv. {2}!",pkmn.name,curLevel))
      @scene.pbLevelUp(pkmn,battler,oldTotalHP,oldAttack,oldDefense,
                                    oldSpAtk,oldSpDef,oldSpeed)
      # Learn all moves learned at this level
      moveList = pkmn.getMoveList
      moveList.each { |m| pbLearnMove(idxParty,m[1]) if m[0]==curLevel }
    end
  end

def pbChangeLevel(pkmn,newlevel,scene)
  newlevel = 1 if newlevel<1
  mLevel = GameData::GrowthRate.max_level
  newlevel = mLevel if newlevel>mLevel
  levelCap=mLevel
  if GYM_BASED
    levelCap=LEVEL_CAPS[$Player.numbadges]
  else
    levelCap=LEVEL_CAPS[$game_variables[VARIABLE_USED]]
  end
  levelCap = growth_rate.minimum_exp_for_level if !levelCap.is_a?(Numeric)
  if newlevel > levelCap #&& !$DEBUG
    pbMessage(_INTL("{1}'s level remained unchanged.",pkmn.name))
    return false
  elsif pkmn.level==newlevel
    pbMessage(_INTL("{1}'s level remained unchanged.",pkmn.name))
	return false
  elsif pkmn.level>newlevel
    attackdiff  = pkmn.attack
    defensediff = pkmn.defense
    speeddiff   = pkmn.speed
    spatkdiff   = pkmn.spatk
    spdefdiff   = pkmn.spdef
    totalhpdiff = pkmn.totalhp
    pkmn.level = newlevel
    pkmn.calc_stats
    scene.pbRefresh
    pbMessage(_INTL("{1} dropped to Lv. {2}!",pkmn.name,pkmn.level))
    attackdiff  = pkmn.attack-attackdiff
    defensediff = pkmn.defense-defensediff
    speeddiff   = pkmn.speed-speeddiff
    spatkdiff   = pkmn.spatk-spatkdiff
    spdefdiff   = pkmn.spdef-spdefdiff
    totalhpdiff = pkmn.totalhp-totalhpdiff
    pbTopRightWindow(_INTL("Max. HP<r>{1}\r\nAttack<r>{2}\r\nDefense<r>{3}\r\nSp. Atk<r>{4}\r\nSp. Def<r>{5}\r\nSpeed<r>{6}",
       totalhpdiff,attackdiff,defensediff,spatkdiff,spdefdiff,speeddiff))
    pbTopRightWindow(_INTL("Max. HP<r>{1}\r\nAttack<r>{2}\r\nDefense<r>{3}\r\nSp. Atk<r>{4}\r\nSp. Def<r>{5}\r\nSpeed<r>{6}",
       pkmn.totalhp,pkmn.attack,pkmn.defense,pkmn.spatk,pkmn.spdef,pkmn.speed))
  else
    attackdiff  = pkmn.attack
    defensediff = pkmn.defense
    speeddiff   = pkmn.speed
    spatkdiff   = pkmn.spatk
    spdefdiff   = pkmn.spdef
    totalhpdiff = pkmn.totalhp
    pkmn.level = newlevel
    pkmn.changeHappiness("vitamin")
    pkmn.calc_stats
    scene.pbRefresh
    if scene.is_a?(PokemonPartyScreen)
      scene.pbDisplay(_INTL("{1} grew to Lv. {2}!",pkmn.name,pkmn.level))
    else
      pbMessage(_INTL("{1} grew to Lv. {2}!",pkmn.name,pkmn.level))
    end
    attackdiff  = pkmn.attack-attackdiff
    defensediff = pkmn.defense-defensediff
    speeddiff   = pkmn.speed-speeddiff
    spatkdiff   = pkmn.spatk-spatkdiff
    spdefdiff   = pkmn.spdef-spdefdiff
    totalhpdiff = pkmn.totalhp-totalhpdiff
    pbTopRightWindow(_INTL("Max. HP<r>+{1}\r\nAttack<r>+{2}\r\nDefense<r>+{3}\r\nSp. Atk<r>+{4}\r\nSp. Def<r>+{5}\r\nSpeed<r>+{6}",
       totalhpdiff,attackdiff,defensediff,spatkdiff,spdefdiff,speeddiff),scene)
    pbTopRightWindow(_INTL("Max. HP<r>{1}\r\nAttack<r>{2}\r\nDefense<r>{3}\r\nSp. Atk<r>{4}\r\nSp. Def<r>{5}\r\nSpeed<r>{6}",
       pkmn.totalhp,pkmn.attack,pkmn.defense,pkmn.spatk,pkmn.spdef,pkmn.speed),scene)
    # Learn new moves upon level up
    movelist = pkmn.getMoveList
    for i in movelist
      next if i[0]!=pkmn.level
      pbLearnMove(pkmn,i[1],true) { scene.pbUpdate }
    end
    # Check for evolution
    newspecies = pkmn.check_evolution_on_level_up
    if newspecies
      pbFadeOutInWithMusic {
        evo = PokemonEvolutionScene.new
        evo.pbStartScreen(pkmn,newspecies)
        evo.pbEvolution
        evo.pbEndScreen
        scene.pbRefresh if scene.is_a?(PokemonPartyScreen)
      }
    end
  end
end

ItemHandlers::UseOnPokemon.add(:RARECANDY,proc { |item,pkmn,scene|
  
  if $PokemonSystem.difficulty >= 2 #<- REPLACE WITH YOUR SETTING $game_variables[id] == X or $game_switches[id] 
    levelCap = LEVEL_CAPS[$Trainer.badge_count]
  else
    levelCap = GameData::GrowthRate.max_level
  end
  
  if pkmn.level>=GameData::GrowthRate.max_level || pkmn.shadowPokemon?
    scene.pbDisplay(_INTL("It won't have any effect."))
    next false
  elsif pkmn.level>levelCap
    scene.pbMessage(_INTL("{1} refuses to eat the Rare Candy.",pkmn.name))
    next false
  elsif pkmn.level==levelCap
    scene.pbMessage(_INTL("{1} refuses to eat the Rare Candy.",pkmn.name))
    next false
  end
  pbChangeLevel(pkmn,pkmn.level+1,scene)
  scene.pbHardRefresh
  next true
})

ItemHandlers::UseOnPokemon.add(:EXPCANDYXS,proc { |item,pkmn,scene|
  if pkmn.level>=GameData::GrowthRate.max_level || pkmn.shadowPokemon?
    scene.pbDisplay(_INTL("It won't have any effect."))
    next false
  end
  if $PokemonSystem.difficulty >= 2 #<- REPLACE WITH YOUR SETTING $game_variables[id] == X or $game_switches[id] 
    levelCap = LEVEL_CAPS[$Trainer.badge_count]
  else
    levelCap = GameData::GrowthRate.max_level
  end
  if (pkmn.level+1) > levelCap
    scene.pbMessage(_INTL("{1} refuses to eat the Candy.",pkmn.name))
	next false
  end
  if (pkmn.growth_rate.level_from_exp(pkmn.exp+100)) > levelCap
    scene.pbMessage(_INTL("{1} refuses to eat the Candy.\\n Would exceed level cap of {2}.",pkmn.name,levelCap))
  	if pbConfirmMessageSerious(_INTL"Bring {1} to level {2}, and waste extra exp?",pkmn.name,levelCap)
	pbAddExp(pkmn,(pkmn.growth_rate.minimum_exp_for_level(levelCap)-pkmn.exp),scene)
	next false
	end
  next false
  end

  pbAddExp(pkmn,100,scene)
  scene.pbHardRefresh
  next true
})

ItemHandlers::UseOnPokemon.add(:EXPCANDYS,proc { |item,pkmn,scene|
  if pkmn.level>=GameData::GrowthRate.max_level || pkmn.shadowPokemon?
    scene.pbDisplay(_INTL("It won't have any effect."))
    next false
  end
  if $PokemonSystem.difficulty >= 2 #<- REPLACE WITH YOUR SETTING $game_variables[id] == X or $game_switches[id] 
    levelCap = LEVEL_CAPS[$Trainer.badge_count]
  else
    levelCap = GameData::GrowthRate.max_level
  end
  if (pkmn.level+1) > levelCap
    scene.pbMessage(_INTL("{1} refuses to eat the Candy.",pkmn.name))
	next false
  end
  if (pkmn.growth_rate.level_from_exp(pkmn.exp+800)) > levelCap
    scene.pbMessage(_INTL("{1} refuses to eat the Candy.\\n Would exceed level cap of {2}.",pkmn.name,levelCap))
  	if pbConfirmMessageSerious(_INTL"Bring {1} to level {2}, and waste extra exp?",pkmn.name,levelCap)
	pbAddExp(pkmn,(pkmn.growth_rate.minimum_exp_for_level(levelCap)-pkmn.exp),scene)
	next false
	end
  next false
  end

  pbAddExp(pkmn,800,scene)
  scene.pbHardRefresh
  next true
})

ItemHandlers::UseOnPokemon.add(:EXPCANDYM,proc { |item,pkmn,scene|
  if pkmn.level>=GameData::GrowthRate.max_level || pkmn.shadowPokemon?
    scene.pbMessage(_INTL("It won't have any effect."))
    next false
  end
  if $PokemonSystem.difficulty >= 2 #<- REPLACE WITH YOUR SETTING $game_variables[id] == X or $game_switches[id] 
    levelCap = LEVEL_CAPS[$Trainer.badge_count]
  else
    levelCap = GameData::GrowthRate.max_level
  end
  if (pkmn.level+1) > levelCap
    scene.pbMessage(_INTL("{1} refuses to eat the Candy.\\n Would exceed level cap of {2}.",pkmn.name,levelCap))
  next false
  end
  if (pkmn.growth_rate.level_from_exp(pkmn.exp+3000)) > levelCap 
    scene.pbMessage(_INTL("{1} refuses to eat the Candy.\\n Would exceed level cap of {2}.",pkmn.name,levelCap))
	if pbConfirmMessageSerious(_INTL"Bring {1} to level {2}, and waste extra exp?",pkmn.name,levelCap)
	pbAddExp(pkmn,(pkmn.growth_rate.minimum_exp_for_level(levelCap)-pkmn.exp),scene)
	next false
	end
  next false
  end

  pbAddExp(pkmn,3000,scene)
  scene.pbHardRefresh
  next true
})

ItemHandlers::UseOnPokemon.add(:EXPCANDYL,proc { |item,pkmn,scene|
  if pkmn.level>=GameData::GrowthRate.max_level || pkmn.shadowPokemon?
    scene.pbDisplay(_INTL("It won't have any effect."))
    next false
  end
  if $PokemonSystem.difficulty >= 2 #<- REPLACE WITH YOUR SETTING $game_variables[id] == X or $game_switches[id] 
    levelCap = LEVEL_CAPS[$Trainer.badge_count]
  else
    levelCap = GameData::GrowthRate.max_level
  end
  if (pkmn.level+1) > levelCap
    scene.pbMessage(_INTL("{1} refuses to eat the Candy.\\n Would exceed level cap of {2}.",pkmn.name,levelCap))
  next false
  end
  if (pkmn.growth_rate.level_from_exp(pkmn.exp+10000)) > levelCap
    scene.pbMessage(_INTL("{1} refuses to eat the Candy.\\n Would exceed level cap of {2}.",pkmn.name,levelCap))
  	if pbConfirmMessageSerious(_INTL"Bring {1} to level {2}, and waste extra exp?",pkmn.name,levelCap)
	pbAddExp(pkmn,(pkmn.growth_rate.minimum_exp_for_level(levelCap)-pkmn.exp),scene)
	next false
	end
  next false
  end

  pbAddExp(pkmn,10000,scene)
  scene.pbHardRefresh
  next true
})

ItemHandlers::UseOnPokemon.add(:EXPCANDYXL,proc { |item,pkmn,scene|
  if pkmn.level>=GameData::GrowthRate.max_level || pkmn.shadowPokemon?
    scene.pbDisplay(_INTL("It won't have any effect."))
    next false
  end
  if $PokemonSystem.difficulty >= 2 #<- REPLACE WITH YOUR SETTING $game_variables[id] == X or $game_switches[id] 
    levelCap = LEVEL_CAPS[$Trainer.badge_count]
  else
    levelCap = GameData::GrowthRate.max_level
  end
  if (pkmn.level+1) > levelCap
    scene.pbMessage(_INTL("{1} refuses to eat the Candy.\\n Would exceed level cap of {2}.",pkmn.name,levelCap))
  next false
  end
  if (pkmn.growth_rate.level_from_exp(pkmn.exp+30000)) > levelCap 
    scene.pbMessage(_INTL("{1} refuses to eat the Candy.\\n Would exceed level cap of {2}.",pkmn.name,levelCap))
  	if pbConfirmMessageSerious(_INTL"Bring {1} to level {2}, and waste extra exp?",pkmn.name,levelCap)
	pbAddExp(pkmn,(pkmn.growth_rate.minimum_exp_for_level(levelCap)-pkmn.exp),scene)
	next false
	end
  next false
  end

  pbAddExp(pkmn,30000,scene)
  scene.pbHardRefresh
  next true
})
end



#===============================================================================
# Boosts Targets' Attack and Defense (Coaching)
#===============================================================================
class PokeBattle_Move_18E < PokeBattle_TargetMultiStatUpMove
  def initialize(battle,move)
    super
    @statUp = [:ATTACK,1,:DEFENSE,1]
  end
end

#===============================================================================
# Move has increased Priority in Grassy Terrain (Grassy Glide)
#===============================================================================
class PokeBattle_Move_18C < PokeBattle_Move
  def pbChangePriority(user)
    return 1 if @battle.field.terrain == :Grassy && !user.airborne?
    return 0
  end
end

#===============================================================================
# Reduces Defense and Raises Speed after all hits (Scale Shot)
#===============================================================================
class PokeBattle_Move_193 < PokeBattle_Move_0C0
  def pbEffectAfterAllHits(user,target)
    if user.pbCanRaiseStatStage?(:SPEED,user,self)
      user.pbRaiseStatStage(:SPEED,1,user)
    end
    if user.pbCanLowerStatStage?(:DEFENSE,target)
      user.pbLowerStatStage(:DEFENSE,1,user)
    end
  end
end

#===============================================================================
# Heals user by 1/2 of its max HP. (CATNAP)
#===============================================================================
class PokeBattle_Move_194 < PokeBattle_HealingMove
	def pbHealAmount(user)
		return (user.totalhp/2.0).round
	end
end

#===============================================================================
# Decreases the target's Attack by 2 stages.
#===============================================================================
class PokeBattle_Move_195 < PokeBattle_TargetStatDownMove
  def initialize(battle,move)
    super
    @statDown = [:ATTACK,2]
  end
end


#===============================================================================
# Decreases the target's Speed by 2 stages.
#===============================================================================
class PokeBattle_Move_196 < PokeBattle_TargetStatDownMove
  def initialize(battle,move)
    super
    @statDown = [:SPEED,2]
  end
end

#===============================================================================
# Decreases the target's Defense by 2 stages.
#===============================================================================
class PokeBattle_Move_197 < PokeBattle_TargetStatDownMove
  def initialize(battle,move)
    super
    @statDown = [:DEFENSE,2]
  end
end
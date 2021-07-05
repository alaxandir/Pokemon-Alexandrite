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
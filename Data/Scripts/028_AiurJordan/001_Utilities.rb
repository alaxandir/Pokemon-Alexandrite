#-------------------------------------------------------------------------------
# AiurJordan's Utilities
# v1.0
# By AiurJordan
#-------------------------------------------------------------------------------
# 
#-------------------------------------------------------------------------------
# v1.0 - Initial Release
#-------------------------------------------------------------------------------
PluginManager.register({
  :name => "AiurJordan Utilities",
  :version => "1.0",
  :credits => ["AiurJordan"],
  :link => "https://reliccastle.com",
})
#-------------------------------------------------------------------------------
# Config
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# 
#-------------------------------------------------------------------------------
class StepCountdown
	attr_accessor :steps
    attr_accessor :decision
  
	def initialize
#@start     = [$game_map.map_id,$game_player.x,$game_player.y,$game_player.direction]
	@start      = nil
	@inProgress = false
	@steps	    = 0
	@decision   = 0
	end

	def pbStart(steps)
    @start      = [$game_map.map_id,$game_player.x,$game_player.y,$game_player.direction]
    @inProgress = true
	@steps      = steps
	end

	def pbEnd
    @start      = nil
    @inProgress = false
    @steps      = 0
    @decision   = 0
    $game_map.need_refresh = true
	end

	def pbGoToStart
	if $scene.is_a?(Scene_Map)
      pbFadeOutIn {
        $game_temp.player_transferring   = true
        $game_temp.transition_processing = true
        $game_temp.player_new_map_id    = @start[0]
        $game_temp.player_new_x         = @start[1]
        $game_temp.player_new_y         = @start[2]
        $game_temp.player_new_direction = 2
        $scene.transfer_player
      }
	end
	end

	def inProgress?
	return @inProgress
	end
end

def pbStepCountdown
	$PokemonGlobal.stepCountdown = StepCountdown.new if !$PokemonGlobal.stepCountdown
	return $PokemonGlobal.stepCountdown
end

def pbInStepCountdown?
	if pbStepCountdown.inProgress?
    # Reception map is handled separately from safari map since the reception
    # map can be outdoors, with its own grassy patches.
    #reception = pbSafariState.pbReceptionMap
    return true if $game_map.name == "Overgrown Ruin"
    map_metadata = GameData::MapMetadata.try_get($game_map.map_id)
    return true if map_metadata && map_metadata.safari_map
	end
	return false
end



Events.onMapChange += proc { |_sender,*args|
  pbStepCountdown.pbEnd if !pbInStepCountdown?
}



Events.onStepTakenTransferPossible += proc { |_sender,e|
  handled = e[0]
  next if handled[0]
    if pbInStepCountdown? && pbStepCountdown.steps > 0
		pbStepCountdown.steps -= 1
		if pbInStepCountdown? && pbStepCountdown.steps == 50
			pbMessage(_INTL("A strange energy is building around you."))
		end
		if pbInStepCountdown? && pbStepCountdown.steps <= 0
			pbMessage(_INTL("A mysterious force sweeps you out of the temple."))
			pbStepCountdown.pbGoToStart
			handled[0] = true
		end
	end
 }

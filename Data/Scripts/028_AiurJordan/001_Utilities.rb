#-------------------------------------------------------------------------------
# AiurJordan's Utilities
# v1.0
# By AiurJordan
#-------------------------------------------------------------------------------
# 
=begin
Optional are blue
Mandatory are green
activateQuest(:Bidoof, colorQuest("blue"),false)
completeQuest(:Bidoof)




=end
#-------------------------------------------------------------------------------
# v1.0 - Initial Release
#-------------------------------------------------------------------------------
PluginManager.register({
  :name => "Extra Utilities",
  :version => "1.0",
  :credits => ["AiurJordan, Boon"],
  :link => "https://reliccastle.com",
})

Essentials::ERROR_TEXT += "[Pokémon Alexandrite v#{Settings::GAME_VERSION}]\r\n"
#-------------------------------------------------------------------------------
# Config
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# ANCIENT RUINS STEP COUNTER
#-------------------------------------------------------------------------------
class StepCountdown
	attr_accessor :steps
    attr_accessor :decision
  
	def initialize
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
		$game_system.save_disabled = false
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


############ MIRROR EVENT by: boon#######################
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

class PokemonTemp
  attr_accessor :mirror_guy_eventid
end

def pbStartMirror(eventid)
  $PokemonTemp.mirror_guy_eventid=eventid
end

def pbEndMirror
  $PokemonTemp.mirror_guy_eventid = nil
end

def caught
  #pbMessage("The shade has reached you, dark thoughts flood your mind.")
  pbEndMirror
end

def move_creepy_event(dir)
  event = $game_map.events[$PokemonTemp.mirror_guy_eventid]
  if $game_player.x == event.x && $game_player.y == event.y
    caught
    return
  end
  case dir
  when 2
    if $game_player.y==event.y-1 && $game_player.x == event.x
      caught
      return
    end
    if $game_map.passable?(event.x,event.y+1,event.direction,event)
	pbMoveRoute(event,[PBMoveRoute::Down])
	end
  when 4
     if $game_player.y==event.y && $game_player.x == event.x-1
      caught
      return
    end
	if $game_map.passable?(event.x+1,event.y,event.direction,event)
	pbMoveRoute(event,[PBMoveRoute::Right])
	end
  when 6
     if $game_player.y==event.y && $game_player.x == event.x+1
      caught
      return
    end
	if $game_map.passable?(event.x-1,event.y,event.direction,event)
	pbMoveRoute(event,[PBMoveRoute::Left])
	end
  when 8
     if $game_player.y==event.y+1 && $game_player.x == event.x
      caught
      return
    end
	if $game_map.passable?(event.x,event.y-1,event.direction,event)
	pbMoveRoute(event,[PBMoveRoute::Up])
	end
  end
end

Events.onStepTakenFieldMovement += proc { |_sender,e|
  event = e[0] # Get the event affected by field movement
  if event==$game_player
    move_creepy_event($game_player.direction) if $PokemonTemp.mirror_guy_eventid != nil
  end
}

class Game_Player
  alias bumpintocreepy bump_into_object
  def bump_into_object
    bumpintocreepy
    move_creepy_event(@direction) if $PokemonTemp.mirror_guy_eventid != nil
  end
end
################# CHECK ENCOUNTER ID'S ON MAP CHANGE

#Check the desert for encounter tables
Events.onMapChanging += proc { |_sender, e|
  new_map_ID = e[0]
  next if new_map_ID == 0
  $PokemonGlobal.encounter_version = [73,74,75].include?($game_map.map_id) && $Trainer.badge_count >= 6 ? 1 : 0
}

#### VENDILY EXPORT MAP

def saveMapScreenShot(mapid)
  map=load_data(sprintf("Data/Map%03d.rxdata",mapid)) rescue nil
  return BitmapWrapper.new(32,32) if !map
  bitmap=BitmapWrapper.new(map.width*32,map.height*32)
  black=Color.new(0,0,0)
  tilesets=load_data("Data/Tilesets.rxdata")
  tileset=tilesets[map.tileset_id]
  return bitmap if !tileset
  helper=TileDrawingHelper.fromTileset(tileset)
  for y in 0...map.height
    for x in 0...map.width
      for z in 0..2
        id=map.data[x,y,z]
        id=0 if !id
        helper.bltTile(bitmap,x*32,y*32,id)
      end
    end
  end
  bitmap.saveToPng(sprintf("Map%03d.png",mapid))
end
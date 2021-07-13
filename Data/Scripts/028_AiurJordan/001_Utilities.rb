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
  :name => "Extra Utilities",
  :version => "1.0",
  :credits => ["AiurJordan, Boon"],
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
###################################
# BERRY SMASHER
##################################
def pbBerrySmash

ret = nil
pbFadeOutIn {
  scene = PokemonBag_Scene.new
  screen = PokemonBagScreen.new(scene,$PokemonBag)
  ret = screen.pbChooseItemScreen(Proc.new { |item| GameData::Item.get(item).is_berry? })
}

if ret
  params = ChooseNumberParams.new
  params.setRange(1, $PokemonBag.pbQuantity(ret))
  params.setInitialValue(1)
  params.setCancelValue(0)
  qty = pbMessageChooseNumber(_INTL("Select the number of {1}.", GameData::Item.get(ret.name_plural, params)))
  $PokemonBag.pbDeleteItem(ret, qty) if qty > 0
end
  
  case $game_variables[1]
	when nil
    pbMessage("Did not select a berry.")
	when :CHERIBERRY
	when :CHESTOBERRY
	when :PECHABERRY
	when :RAWSTBERRY
	when :ASPEARBERRY
	when :LEPPABERRY
	when :ORANBERRY
	when :PERSIMBERRY
	when :LUMBERRY
	when :SITRUSBERRY
	when :FIGYBERRY
	when :WIKIBERRY
	when :MAGOBERRY
	when :AGUAVBERRY
	when :IAPAPABERRY
	when :RAZZBERRY
	when :BLUKBERRY
	when :NANABBERRY
	when :WEPEARBERRY
	when :PINAPBERRY
	when :POMEGBERRY
	when :KELPSYBERRY
	when :QUALOTBERRY
	when :HONDEWBERRY
	when :GREPABERRY
	when :TAMATOBERRY
	when :CORNNBERRY
	when :MAGOSTBERRY
	when :RABUTABERRY
	when :NOMELBERRY
	when :SPELONBERRY
	when :PAMTREBERRY
	when :WATMELBERRY
	when :DURINBERRY
	when :BELUEBERRY
	when :OCCABERRY
	when :PASSHOBERRY
	when :WACANBERRY
	when :RINDOBERRY
	when :YACHEBERRY
	when :CHOPLEBERRY
	when :KEBIABERRY
	when :SHUCABERRY
	when :COBABERRY
	when :PAYAPABERRY
	when :TANGABERRY
	when :CHARTIBERRY
	when :KASIBBERRY
	when :HABANBERRY
	when :COLBURBERRY
	when :BABIRIBERRY
	when :CHILANBERRY
	when :LIECHIBERRY
	when :GANLONBERRY
	when :SALACBERRY
	when :PETAYABERRY
	when :APICOTBERRY
	when :LANSATBERRY
	when :STARFBERRY
	when :ENIGMABERRY
	when :MICLEBERRY
	when :CUSTAPBERRY
	when :JABOCABERRY
	when :ROWAPBERRY
	end
end
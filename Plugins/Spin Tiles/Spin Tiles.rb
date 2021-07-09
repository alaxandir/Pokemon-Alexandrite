#===============================================================================
# Spin Tiles - By Vendily, thepsynergist & Barrel's O'Fun [v17]
#===============================================================================
# This script adds in Spin tiles, a Pokémon staple! Once the player steps on
#  one of these tiles, they'll go spinning in the direction on the tile
#  until they hit an impassable object or the a Stop tile. Hitting another
#  spin tile redirects the player.
#===============================================================================
# To use it, you must create 4 new tiles with terrain tags specifing the
#  spun direction. Remember to change the presets if you have other terrain tags
#  installed!
# The newly Added Stop tile is tag 23, but you can set it to -1 if you
#  aren't using it. 
# There's also some extra edits:
#  "def character_name" in Game_Player_Visuals.
#  under:
#          # Display running character sprite
#          @character_name = pbGetPlayerCharset(meta,4)
#  put:
#        elsif $PokemonGlobal.spinning
#          @character_name = pbGetPlayerCharset(meta,7)
# If you have another script that also edits the metadata for the player, 
#  remember to change the 7 above to the new position in the list.
#
#  Also, in "def pbCanRun?" in Game_Player_Visuals, add a check for 
#   $PokemonGlobal.spinning, so you can't run while you're spinning.
#
#  Finally, in "def update" in Game_Player_Visuals.
#  under:
#    if PBTerrain.isIce?(pbGetTerrainTag)
#      @move_speed = ($RPGVX) ? 6.5 : 4.8 # Sliding on ice
#  put:
#    elsif $PokemonGlobal.spinning
#      @move_speed = ($RPGVX) ? 4.5 : 3.8 # Spinning
#  (Adjust the values if you want faster or slower spinning, this is walk speed)
#
# You also have to add a new image to the Player fields in metadata.txt
#  Here's mine
# PlayerA=POKEMONTRAINER_Red,trchar000,boy_bike,boy_surf,boy_run,boy_surf,boy_fish_offset,boy_spin,xxx
#  "boy_spin" is the new one, a graphic that has has each column in a different direction
#  so Down standing, Left standing, Up Standing, Right standing.
#  You can swap left and right, pretty sure, if that looks better.
#
#===============================================================================
 
 UP_TAG = 19
 DOWN_TAG = 20
 LEFT_TAG = 21
 RIGHT_TAG = 22
 STOP_TAG = 23
 
module PBTerrain
  SpinTileUp    = UP_TAG
  SpinTileDown  = DOWN_TAG
  SpinTileLeft  = LEFT_TAG
  SpinTileRight = RIGHT_TAG
  SpinTileStop  = STOP_TAG
  
def PBTerrain.isSpinTile?(tag)
  return   tag==PBTerrain::SpinTileUp 	||
           tag==PBTerrain::SpinTileDown ||
           tag==PBTerrain::SpinTileLeft ||
           tag==PBTerrain::SpinTileRight	
  end
end

GameData::TerrainTag.register({
  :id                     => :SpinTileUp,
  :id_number              => UP_TAG
})
GameData::TerrainTag.register({
  :id                     => :SpinTileDown,
  :id_number              => DOWN_TAG
})
GameData::TerrainTag.register({
  :id                     => :SpinTileLeft,
  :id_number              => LEFT_TAG
})
GameData::TerrainTag.register({
  :id                     => :SpinTileRight,
  :id_number              => RIGHT_TAG
})
GameData::TerrainTag.register({
  :id                     => :SpinTileStop,
  :id_number              => STOP_TAG
})
 
class PokemonGlobalMetadata
  attr_accessor :spinning
  
  def spinning
    @spinning=false if !@spinning
    return @spinning
  end
end
 
Events.onStepTakenFieldMovement+=proc {|sender,e|
  event = e[0] # Get the event affected by field movement
  if $scene.is_a?(Scene_Map)
    currentTag = $game_player.pbTerrainTag
    if event==$game_player && PBTerrain.isSpinTile?(currentTag) && !$PokemonGlobal.sliding      
      Kernel.pbSpinTile(event)
    end
  end
}
 
def Kernel.pbSpinTile(event=nil)  
  event = $game_player if !event
  return if !event
  tag = $game_player.pbTerrainTag
  return if !PBTerrain.isSpinTile?(tag)
  oldwalkanime = event.walk_anime
  pbSEPlay("Player jump")
  event.move_speed == 1
  if $PokemonGlobal.spinning == false
    event.straighten
  end
  event.walk_anime = false
  case tag
  when PBTerrain::SpinTileUp
    event.turn_up
   if $PokemonGlobal.spinning == false
      event.pattern=2
   end
  when PBTerrain::SpinTileDown
    event.turn_down
   if $PokemonGlobal.spinning == false
      event.pattern=0
   end
  when PBTerrain::SpinTileRight
    event.turn_right
   if $PokemonGlobal.spinning == false
      event.pattern=1
   end
  when PBTerrain::SpinTileLeft
    event.turn_left
   if $PokemonGlobal.spinning == false
      event.pattern=3
   end
 end  
  event.walk_anime = true
  $PokemonGlobal.spinning = true
  loop do
    break if !event.passable?(event.x,event.y,event.direction)
    tag = $game_player.pbTerrainTag
    break if tag == STOP_TAG
    if PBTerrain.isSpinTile?(tag)
      case tag
      when PBTerrain::SpinTileUp
        event.turn_up
      when PBTerrain::SpinTileDown
        event.turn_down
     when PBTerrain::SpinTileRight
        event.turn_right        
      when PBTerrain::SpinTileLeft
        event.turn_left
      end
    end    
    event.move_forward
	pbSEPlay("GUI Storage put down")
    while event.moving?
      Graphics.update
      Input.update
      pbUpdateSceneMap
    end
  end  
  event.center(event.x,event.y)
  event.walk_anime = oldwalkanime  
  $PokemonGlobal.spinning = false
 end
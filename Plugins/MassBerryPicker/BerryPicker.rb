################################################################################
# Mass Berry Picker Script by:
# - PurpleZaffre
# Please give credits when using this.
################################################################################

if defined?(PluginManager)
  PluginManager.register({
    :name => "Mass Berry Picker Script",
    :version => "1.0",
    :credits => "PurpleZaffre",
  })
end

# num1 : lowest ID of all the berry tree events
# num2 : highest ID of all the berry tree events
# map  : ID of the map where the berries are (if left blank, the ID of the map
# where the player currently is will be used)
def pbMassBerryPicker(num1,num2,map=nil)
  map = $game_map.map_id if map == nil
  harvestedBerries = false
  for i in num1..num2
    berryData = $PokemonGlobal.eventvars[[map,i]]
    if berryData
      berryToReceive=berryData[1]
      if berryData[0] == 5
        berryvalues=pbGetBerryPlantData(berryData[1])
        berrycount=1
        if berryData.length>6
          berrycount=[berryvalues[3]-berryData[6],berryvalues[2]].max
        else
          if berryData[4]>0
            randomno=rand(1+berryvalues[3]-berryvalues[2])
            berrycount=(((berryvalues[3]-berryvalues[2])*(berryData[4]-1)+randomno)/4).floor+berryvalues[2]
          else
            berrycount=berryvalues[2]
          end
        end
        $PokemonBag.pbStoreItem(berryToReceive,berrycount)
        harvestedBerries = true
        $PokemonGlobal.eventvars[[map,i]][0]=0
        $game_map.refresh
        pbWait(1)
        $PokemonGlobal.eventvars[[map,i]]=nil
        $game_map.refresh
        pbWait(1)
        if NEW_BERRY_PLANTS
          berryData=[0,0,0,0,0,0,0,0]
        else
          berryData=[0,0,false,0,0,0]
        end
      end
    end
  end
# Change these messages to whatever you want
  if harvestedBerries == true
    pbMessage(_INTL("\\me[Item get]\\PN got some berries!\\wtnp[30]"))
  else
    pbMessage(_INTL("There are no berries to pick right now."))
  end
end
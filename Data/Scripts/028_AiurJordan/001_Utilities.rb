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
CHOICES=[
#Each array is a separate list of Megastones for the player to choose from
[:AERODACTYLITE,:ALAKAZITE,:ALTARIANITE,
:CAMERUPTITE,:GARCHOMPITE,:GARDEVOIRITE,
:GENGARITE,:HOUNDOOMINITE,:LUCARIONITE,
:MEDICHAMITE,:METAGROSSITE,:PIDGEOTITE,
:SABLENITE,:SALAMENCITE,:SCEPTILITE],
[:PIDGEOTITE,
 :GENGARITE]
]

COSTS=[
#Array index corresponds to the megastone list chosen (CHOICES)
#GREENSHARD,BLUESHARD,REDSHARD,YELLOWSHARD
[1,1,0,1, 0,1,0,2, 0,2,1,0,
 0,0,1,1, 2,3,1,2, 1,2,1,0,
 1,1,0,2, 1,0,2,0, 3,0,1,0,
 1,1,1,1, 2,0,3,3, 0,1,0,1,
 1,0,0,1, 4,4,0,0, 2,0,0,1 ],
[3,0,0,0,
 4,0,0,0]
]
#-------------------------------------------------------------------------------
# 
#-------------------------------------------------------------------------------

def pbMegastoneSynthesis(list,cost)
	@megastone = CHOICES[list]
	@cost	= COSTS[cost]

	stone = @megastone
	cost = @cost
	megastone_commands = []
	mega_cmd = 0
	cmd = 0

	for i in 0...stone.length
	  megastone_commands.push(GameData::Item.get(stone[i]).name)
	  mega_cmd = megastone_commands.length
	  break if cmd < 0
	end
	mega_cmd = pbMessage(_INTL("Choose a Mega Stone."), megastone_commands, mega_cmd)
	i = mega_cmd
	stonech = GameData::Item.get(stone[i]).name
	
	green 	= cost[i*4]
	blue 	= cost[i*4+1]
	red 	= cost[i*4+2]
	yellow 	= cost[i*4+3]

	if pbConfirmMessageSerious("<ac>\\l[3]You want #{stonech}?<fs=34>\\n\\c[3]#{green}(G) <icon=GREENSHARD> \\c[1]#{blue}(B) <icon=BLUESHARD> \\c[2]#{red}(R) <icon=REDSHARD> \\c[6]#{yellow}(Y) <icon=YELLOWSHARD> </ac>")
		if (green > $PokemonBag.pbQuantity(:GREENSHARD) || blue > $PokemonBag.pbQuantity(:BLUESHARD) || red > $PokemonBag.pbQuantity(:REDSHARD) || yellow > $PokemonBag.pbQuantity(:YELLOWSHARD))
			pbMessage("You don't have enough shards.")
		elsif $PokemonBag.pbHasItem?(GameData::Item.get(stone[i]))
			pbMessage("You already have #{stonech}.")
		elsif $PokemonBag.pbCanStore?(GameData::Item.get(stone[i]))
			pbSEPlay('Megastone')
			pbMessage("\\PN handed over the shards, and synthesized #{stonech}!")
			pbReceiveItem(GameData::Item.get(stone[i]))
			$PokemonBag.pbDeleteItem(:GREENSHARD,green)
			$PokemonBag.pbDeleteItem(:BLUESHARD,green)
			$PokemonBag.pbDeleteItem(:REDSHARD,green)
			$PokemonBag.pbDeleteItem(:YELLOWSHARD,green)
		end
	end
end


module QuestModule
  # You don't actually need to add any information, but the respective fields in the UI will be blank or "???"
  # I included this here mostly as an example of what not to do, but also to show it's a thing that exists
  # Here's the simplest example of a single-stage quest with everything specified
Main = {
    :ID => "13",
    :Name => "Pokémon League",
    :QuestGiver => "Professor Yew",
    :Stage1 => "Obtain the Tide Badge.",
	:Stage2 => "Obtain the Granite Badge.",
	:Stage3 => "Obtain the Hive Badge.",
	:Stage4 => "Obtain the Blaze Badge.",
	:Stage5 => "Obtain the Circuit Badge.",
	:Stage6 => "Obtain the Shatter Badge.",
	:Stage7 => "Obtain the Focus Badge.",
	:Stage8 => "Obtain the Dynasty Badge.",
	:Stage9 => "Defeat the Elite Four.",
    :Location1 => "Seafoam City",
    :Location2 => "Bouldergrove City.",
	:Location3 => "Anthrophil City.",
	:Location4 => "Emberton City.",
	:Location5 => "Neon City.",
	:Location6 => "Glacier City.",
	:Location7 => "Soul City.",
	:Location8 => "Fortune City.",
	:Location9 => "Pokémon League.",
    :QuestDescription => "Rise to the challenge and defeat the Cardino Pokémon League. Green quests must be completed in order to progress towards this goal.",
    :RewardString => "Hall of Fame Entry."
  }
  
Bidoof = {
    :ID => "14",
    :Name => "Show me a Bidoof",
    :QuestGiver => "Little Girl",
    :Stage1 => "Capture and show a Bidoof.",
    :Location1 => "Earthroot Town",
    :QuestDescription => "A little girl has asked you to show her a Bidoof.",
    :RewardString => "Valuable Item"
  }
  
Pichu = {
    :ID => "15",
    :Name => "Looking for a Pichu",
    :QuestGiver => "Searching Boy",
    :Stage1 => "Trade a Pichu to the boy.",
    :Location1 => "Route 101",
    :QuestDescription => "A boy on Route 101 is searching for a Pichu. He has offered to trade you a Lucky Egg in exchange for this Pokémon.",
    :RewardString => "Lucky Egg"
  }
  
Bike = {
    :ID => "16",
    :Name => "Finding his Sea Legs",
    :QuestGiver => "Sailor Bill",
    :Stage1 => "Defeat the Gym Leader.",
    :Location1 => "Seafoam City",
    :QuestDescription => "The Sailor has offered to exchange his bike for beating the Seafoam City Gym Leader.",
    :RewardString => "Bicycle"
  }
  
Cubone = {
    :ID => "17",
    :Name => "Rare Pokémon In The Cave",
    :QuestGiver => "Pokémon Supernerd",
    :Stage1 => "Find Cubone in Seafoam Cave.",
    :Location1 => "Seafoam City",
    :QuestDescription => "The Pokémaniac wants to see a rare Cubone.",
    :RewardString => "Thick Club"
  }
  
Powerplant = {
    :ID => "18",
    :Name => "The Powerplant",
    :QuestGiver => "Pokémon Encyclopedia",
    :Stage1 => "Check out the Powerplant",
    :Location1 => "Bouldergrove City",
    :QuestDescription => "Team Rocket has taken over the Powerplant! Find out what they're planning.",
    :RewardString => "Story Progress"
  }
  
  
VULPIX = {
    :ID => "19",
    :Name => "TRADE: Geodude for Vulpix",
    :QuestGiver => "Lass",
    :Stage1 => "Trade a Geodude for a Vuplix",
    :Location1 => "Bouldergrove Apartments",
    :QuestDescription => "A trainer wants to trade Pokémon with you. Your Geodude for her Vulpix.",
    :RewardString => "Vulpix"
  }

  
COALMINE = {
    :ID => "20",
    :Name => "AREA: Bouldergrove Coalmine",
    :QuestGiver => "nil",
    :Stage1 => "Travel to Glacier City.",
    :Location1 => "Bouldergrove City",
    :QuestDescription => "A coalmine in the north of Bouldergrove has collapsed, A man suggested checking Glacier City for a special hammer.",
    :RewardString => "Side Area"
  }
  
VOLTORB = {
    :ID => "21",
    :Name => "TRADE: Patrat for Voltorb",
    :QuestGiver => "Captain",
    :Stage1 => "Trade a Patrat for a Voltorb",
    :Location1 => "Seafoam Apartment",
    :QuestDescription => "A trainer wants to trade Pokémon with you. Your Patrat for his Voltorb.",
    :RewardString => "Voltorb"
  }
  
FARFETCHD = {
    :ID => "22",
    :Name => "TRADE: Fearow for Farfetch'd",
    :QuestGiver => "Bird Keeper",
    :Stage1 => "Trade a Fearow for a Farfetch'd",
    :Location1 => "Anthrophil PKMN Center",
    :QuestDescription => "A trainer wants to trade Pokémon with you. Your Fearow for his Farfetch'd.",
    :RewardString => "Galarian Farfetch'd"
  }
  
GAMECORNER = {
    :ID => "23",
    :Name => "Rocket has a thing with Game Corners.",
    :QuestGiver => "Professor Yew",
    :Stage1 => "Investigate the Game Corner.",
    :Location1 => "Anthrophil Game Corner",
    :QuestDescription => "Team Rocket has some kind of influence over the Anthrophil Game Corner. One of your Dad's assistants has gone missing and he suspects they can be found there.",
    :RewardString => "Story Progress"
  }
  
MUSEUM = {
    :ID => "24",
    :Name => "Night at the Museum",
    :QuestGiver => "nil",
    :Stage1 => "They went that way!",
    :Location1 => "Ancient Cave",
    :QuestDescription => "Follow Team Rocket's trail to the Ancient Cave to try to discover why they would steal the Pokémon Fossils.",
    :RewardString => "Story Progress"
  }

COMFEY = {
    :ID => "25",
    :Name => "TRADE: Heracross for Comfey",
    :QuestGiver => "Scientist",
    :Stage1 => "Trade a Heracross for a Comfey",
    :Location1 => "Emberton PKMN Center",
    :QuestDescription => "A trainer wants to trade Pokémon with you. Your Heracross for his Comfey.",
    :RewardString => "Comfey"
  }
  
POLIWHIRL = {
    :ID => "26",
    :Name => "Eve's Stolen Poliwhirl!",
    :QuestGiver => "Pokémon Trainer Eve",
    :Stage1 => "Find the stolen Poliwhirl",
    :Location1 => "Shimmerwood Forest",
    :QuestDescription => "Eve's Poliwhirl was taken from her by Team Rocket! Track them down together with her and save her Pokémon. Eve can be found in the house within Shimmerwood Forest.",
    :RewardString => "Story Progress"
  }
  
SILPH = {
    :ID => "27",
    :Name => "Silph Company",
    :QuestGiver => "nil",
    :Stage1 => "Factory Shutdown",
    :Location1 => "Neon City",
	:Stage2 => "Find the lost Silph Pass",
    :Location2 => "Mount Mauve",
	:Stage3 => "Investigate the Silph Co.",
    :Location3 => "Neon City",
    :QuestDescription => "The Silph Company has been making some strange decisions lately, including shutting down the Cardino Factory, get to the bottom of this problem. Talk to people around Neon City to find out more information.",
    :RewardString => "Story Progress"
  }

THRONE = {
    :ID => "28",
    :Name => "Throne of Thunder",
    :QuestGiver => "nil",
    :Stage1 => "Collect the Crystals",
    :Location1 => "Mount Mauve",
    :QuestDescription => "Crystals forged of elements bold, keys to the throne inside they hold. Tidal waves, lakes of fire, dragon lord doth here retire.",
    :RewardString => "Legendary Encounter"
  }
  
SPIRITS = {
    :ID => "29",
    :Name => "Spiritual Disturbance",
    :QuestGiver => "nil",
    :Stage1 => "Investigate the Spirit Tower",
    :Location1 => "Spirit Garden",
    :QuestDescription => "Leader Lee is dealing with some disturbance at the Pokémon Spirit Tower, discover what is going on!",
    :RewardString => "Story Progress"
  }

CYBERATTACK = {
    :ID => "30",
    :Name => "Cyber Attack",
    :QuestGiver => "Jordan",
    :Stage1 => "Pokémon storage is offline?",
    :Location1 => "Anthrophil Lab",
    :QuestDescription => "Team Rocket has managed to shut down the Pokémon Storage System! Get to Anthrophil as soon as possible and find out what's going on.",
    :RewardString => "Story Progress"
  }
  
ROCKETBASE = {
    :ID => "31",
    :Name => "Operation Mega Ring",
    :QuestGiver => "Jordan",
    :Stage1 => "Infiltrate Team Rocket's Base",
    :Location1 => "Anthrophil Lab",
    :QuestDescription => "Jordan has managed to trace the location of Team Rocket's base, speak to him at Anthrophil Lab. All of the regions Gym Leaders have been summoned to Victory Plateau for an emergency meeting.",
    :RewardString => "Story Progress"
  }

GOREBYSS = {
    :ID => "32",
    :Name => "TRADE: Golduck for Gorebyss",
    :QuestGiver => "Fisherman",
    :Stage1 => "Trade a Golduck for a Gorebyss",
    :Location1 => "Glacier City PKMN Center",
    :QuestDescription => "A trainer wants to trade Pokémon with you. Your Golduck for his Gorebyss.",
    :RewardString => "Gorebyss"
  }

EXEGGUTOR = {
    :ID => "33",
    :Name => "TRADE: Manectric for Exeggutor",
    :QuestGiver => "Lady Sarah",
    :Stage1 => "Trade a Manectric for Exeggutor",
    :Location1 => "Neon City PKMN Center",
    :QuestDescription => "A trainer wants to trade Pokémon with you. Your Manectric for her Exeggutor.",
    :RewardString => "Alolan Exeggutor"
  }

SIREN = {
    :ID => "34",
    :Name => "Siren's Peak, the mysterious cry.",
    :QuestGiver => "nil",
    :Stage1 => "Reach Siren's Cave.",
    :Location1 => "Siren's Peak",
    :QuestDescription => "A mysterious cry has been heard coming from Siren's Peak. Investigate to find the source.",
    :RewardString => "Alolan Exeggutor"
  }
  
SUPERROD = {
    :ID => "35",
    :Name => "Gone Fishin'",
    :QuestGiver => "nil",
    :Stage1 => "Obtain a Gorebyss",
    :Location1 => "Lighthouse, Route 116",
    :QuestDescription => "The lighthouse operator wants to see a Gorebyss to prove you're a capable angler.",
    :RewardString => "Super Rod"
  }

RUINS = {
    :ID => "36",
    :Name => "The Missing Link",
    :QuestGiver => "nil",
    :Stage1 => "SS. Alice",
    :Location1 => "Fortune City",
	:Stage2 => "Origin Puzzlekey",
    :Location2 => "Origin Valley",
	:Stage3 => "The Six Trials",
    :Location3 => "Origin Cave",
    :QuestDescription => "A missing link has been discovered in regards to accessing the ruins in Origin Valley! Explore the Verdant Jungle and see what clues you can uncover.",
    :RewardString => "Post-game Content"
  }
  
POLIWAG = {
    :ID => "37",
    :Name => "TRADE: Pidgey for Poliwag",
    :QuestGiver => "Fat Guy",
    :Stage1 => "Trade a Pidgey for Poliwag",
    :Location1 => "Trident Cove PKMN Center",
    :QuestDescription => "A trainer wants to trade Pokémon with you. Your Pidgey for his Poliwag.",
    :RewardString => "Poliwag"
  }

CHARMELEON = {
    :ID => "38",
    :Name => "TRADE: Pikachu for Charmeleon",
    :QuestGiver => "Lass",
    :Stage1 => "Trade a Pikachu for Charmeleon",
    :Location1 => "Route 109 PKMN Center",
    :QuestDescription => "A trainer wants to trade Pokémon with you. Your Pikachu for his Charmeleon.",
    :RewardString => "Charmeleon"
  }
  
SWEETTOOTH = {
    :ID => "39",
    :Name => "A sweet tooth.",
    :QuestGiver => "Candy Fanatic",
    :Stage1 => "Bring a Root Candy bar to the Fanatic.",
    :Location1 => "Fortune City",
    :QuestDescription => "A candy fanatic has asked you to retrieve a Root Candy Bar from Earthroot and bring it to him.",
    :RewardString => "Valuable Item"
  }

CHARCOAL = {
    :ID => "40",
    :Name => "Fuel for the Winter.",
    :QuestGiver => "Concerned Mother",
    :Stage1 => "Bring Charcoal to the Mother.",
    :Location1 => "Glacier City",
    :QuestDescription => "A woman is concerned about having enough fuel for the winter, you could be nice and bring her Charcoal.",
    :RewardString => "Lum Berries"
  }
  
DUNSPARCE = {
    :ID => "41",
    :Name => "The Lonely Dunsparce.",
    :QuestGiver => "nil",
    :Stage1 => "Give Popping Candy to Dunsparce",
    :Location1 => "Neon City",
    :QuestDescription => "You found a scared and lonely Dunsparce hiding in a back alley. Time to make friends!",
    :RewardString => "Dunsparce"
  }

STARYU = {
    :ID => "42",
    :Name => "TRADE: Diglett for Staryu",
    :QuestGiver => "Swimmer Erick",
    :Stage1 => "Trade a Diglett for a Vuplix",
    :Location1 => "Gold Coast",
    :QuestDescription => "A trainer wants to trade Pokémon with you. Your Diglett for his Staryu.",
    :RewardString => "Staryu"
  }

EEVEE = {
    :ID => "43",
    :Name => "Eevee's Hungry!",
    :QuestGiver => "School Girl",
    :Stage1 => "Give Eevee a Tamato Berry.",
	:Stage2 => "Give Eevee a Rawst Berry.",
	:Stage3 => "Give Eevee a Sitrus Berry.",
    :Location1 => "Route 104",
    :Location2 => "Route 104",
	:Location3 => "Route 104",
    :QuestDescription => "A young trainer's Eevee is upset and hungry! Give it some berries!",
    :RewardString => "Eevee"
  }

MINING = {
    :ID => "44",
    :Name => "Mining Expedition!",
    :QuestGiver => "Archaeologist",
    :Stage1 => "Get a Pickaxe and Fresh Water!",
	:Stage2 => "Get a Pickaxe and Fresh Water!",
    :Location1 => "Saltstone Villa",
	:Location2 => "Saltstone Villa",
    :QuestDescription => "The archeologist explained that you can go mining for rare items if you craft a pickaxe and have some Fresh Water. You can find the ingredients from Aggron (Hardstone) and Marowak (Thick Club).",
    :RewardString => "Mining Expedition"
  }
  
HOPPIP = {
    :ID => "45",
    :Name => "She's crazy about Hoppip",
    :QuestGiver => "Preschooler",
    :Stage1 => "Show her a Hoppip",
    :Location1 => "Emberton",
    :QuestDescription => "A little girl wants to see a Hoppip, can you find one to show her?",
    :RewardString => "Soothe Bell"
  }
  
DEINO = {
    :ID => "46",
    :Name => "TRADE: Slowking for Deino",
    :QuestGiver => "Supernerd",
    :Stage1 => "Trade Slowking",
    :Location1 => "Saltstone Villa",
    :QuestDescription => "A supernerd wants to trade Pokémon with you. Your Slowking for his Deino.",
    :RewardString => "Deino"
  }
  
SEAVOUCHER = {
    :ID => "47",
    :Name => "The Sea Voucher!",
    :QuestGiver => "Leader Lee",
    :Stage1 => "Talk to the Gate Guard.",
	:Stage2 => "Deliver Jake's Parcel.",
	:Stage3 => "Talk to the Gate Guard.",
    :Location1 => "Trident Cove Town",
	:Location2 => "Saltstone Villa",
	:Location3 => "Trident Cove Town.",
    :QuestDescription => "Lee wants you to travel to Trident Cove so you can challenge the 8th gym, but you'll need a Sea Voucher. Lee told you he knows the guard and that he can help you out.",
    :RewardString => "Sea Voucher"
  }
  
FINALGAMBIT = {
    :ID => "48",
    :Name => "The Final Gambit.",
    :QuestGiver => "Prof. Yew",
    :Stage1 => "Talk to Prof. Yew at the Lab",
	:Stage2 => "Investigate the Origin Ruins",
	:Stage3 => "Take the boat from Gold Coast",
	:Stage4 => "Destroy the Power-plant",
    :Location1 => "Anthrophil Lab",
	:Location2 => "Origin Ruins",
	:Location3 => "Gold Coast",
	:Location4 => "Rocket Island",
    :QuestDescription => "Prof. Yew wants to talk to you about a final assault on Rocket's home base.",
    :RewardString => "Post-game Story"
  }

Vileplume = {
    :ID => "49",
    :Name => "Show me a Vileplume",
    :QuestGiver => "Plant Lady",
    :Stage1 => "Obtain a Vileplume",
    :Location1 => "Goldcoast",
    :QuestDescription => "A slightly scary plant obsessed lady has asked you to show her a Vileplume.",
    :RewardString => "Balm Mushroom"
  }
  
TORCHIC = {
    :ID => "50",
    :Name => "TRADE: Bulbasaur for Torchic",
    :QuestGiver => "Gentleman",
    :Stage1 => "Trade a Bulbasaur for a Torchic",
    :Location1 => "Bouldergrove PKMN Center",
    :QuestDescription => "A trainer wants to trade Pokémon with you. Your Bulbasaur for his Torchic.",
    :RewardString => "Torchic"
  }
  
BAGON = {
    :ID => "51",
    :Name => "TRADE: Leafeon for Bagon",
    :QuestGiver => "Lass",
    :Stage1 => "Trade a Leafeon for a Bagon",
    :Location1 => "Emberton Museum",
    :QuestDescription => "A trainer wants to trade Pokémon with you. Your Leafeon for his Bagon.",
    :RewardString => "Bagon"
  }
  
BATTLEACADEMY = {
    :ID => "52",
    :Name => "Recruits for the Academy",
    :QuestGiver => "Coordinator",
    :Stage1 => "Find trainers to recruit",
    :Location1 => "Seafoam City",
    :QuestDescription => "The coordinator of the Battle Academy asked you to recruit trainers. If you find any trainers willing to join you should ask them!",
    :RewardString => "Academy Battles"
  }
  
ORICORIO = {
    :ID => "53",
    :Name => "To be a Dancer",
    :QuestGiver => "Oricorio",
    :Stage1 => "Impress the Oricorio with a dance.",
    :Location1 => "Gold Coast",
    :QuestDescription => "The Oricorio of Gold Coast are hard to please, maybe a new dance will impress them!",
    :RewardString => "???"
  }
end

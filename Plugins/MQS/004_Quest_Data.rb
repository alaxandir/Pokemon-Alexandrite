module QuestModule
  
  # You don't actually need to add any information, but the respective fields in the UI will be blank or "???"
  # I included this here mostly as an example of what not to do, but also to show it's a thing that exists
  Quest0 = {
  
  }
  
  # Here's the simplest example of a single-stage quest with everything specified
  Quest1 = {
    :ID => "1",
    :Name => "Introductions",
    :QuestGiver => "Little Boy",
    :Stage1 => "Look for clues.",
    :Location1 => "Lappet Town",
    :QuestDescription => "Some wild Pokémon stole a little boy's favourite toy. Find those troublemakers and help him get it back.",
    :RewardString => "Something shiny!"
  }
  
  # Here's an extension of the above that includes multiple stages
  Quest2 = {
    :ID => "2",
    :Name => "Introductions",
    :QuestGiver => "Little Boy",
    :Stage1 => "Look for clues.",
    :Stage2 => "Follow the trail.",
    :Stage3 => "Catch the troublemakers!",
    :Location1 => "Lappet Town",
    :Location2 => "Viridian Forest",
    :Location3 => "Route 3",
    :QuestDescription => "Some wild Pokémon stole a little boy's favourite toy. Find those troublemakers and help him get it back.",
    :RewardString => "Something shiny!"
  }
  
  # Here's an example of a quest with lots of stages that also doesn't have a stage location defined for every stage
  Quest3 = {
    :ID => "3",
    :Name => "Last-minute chores",
    :QuestGiver => "Grandma",
    :Stage1 => "A",
    :Stage2 => "B",
    :Stage3 => "C",
    :Stage4 => "D",
    :Stage5 => "E",
    :Stage6 => "F",
    :Stage7 => "G",
    :Stage8 => "H",
    :Stage9 => "I",
    :Stage10 => "J",
    :Stage11 => "K",
    :Stage12 => "L",
    :Location1 => "nil",
    :Location2 => "nil",
    :Location3 => "Dewford Town",
    :QuestDescription => "Isn't the alphabet longer than this?",
    :RewardString => "Chicken soup!"
  }
  
  # Here's an example of not defining the quest giver and reward text
  Quest4 = {
    :ID => "4",
    :Name => "A new beginning",
    :QuestGiver => "nil",
    :Stage1 => "Turning over a new leaf... literally!",
    :Stage2 => "Help your neighbours.",
    :Location1 => "Milky Way",
    :Location2 => "nil",
    :QuestDescription => "You crash landed on an alien planet. There are other humans here and they look hungry...",
    :RewardString => "nil"
  }
  
  # Other random examples you can look at if you want to fill out the UI and check out the page scrolling
  Quest5 = {
    :ID => "5",
    :Name => "All of my friends",
    :QuestGiver => "Barry",
    :Stage1 => "Meet your friends near Acuity Lake.",
    :QuestDescription => "Barry told me that he saw something cool at Acuity Lake and that I should go see. I hope it's not another trick.",
    :RewardString => "You win nothing for giving in to peer pressure."
  }
  
  Quest6 = {
    :ID => "6",
    :Name => "The journey begins",
    :QuestGiver => "Professor Oak",
    :Stage1 => "Deliver the parcel to the Pokémon Mart in Viridian City.",
    :Stage2 => "Return to the Professor.",
    :Location1 => "Viridian City",
    :Location2 => "nil",
    :QuestDescription => "The Professor has entrusted me with an important delivery for the Viridian City Pokémon Mart. This is my first task, best not mess it up!",
    :RewardString => "nil"
  }
  
  Quest7 = {
    :ID => "7",
    :Name => "Close encounters of the... first kind?",
    :QuestGiver => "nil",
    :Stage1 => "Make contact with the strange creatures.",
    :Location1 => "Rock Tunnel",
    :QuestDescription => "A sudden burst of light, and then...! What are you?",
    :RewardString => "A possible probing."
  }
  
  Quest8 = {
    :ID => "8",
    :Name => "These boots were made for walking",
    :QuestGiver => "Musician #1",
    :Stage1 => "Listen to the musician's, uhh, music.",
    :Stage2 => "Find the source of the power outage.",
    :Location1 => "nil",
    :Location2 => "Celadon City Sewers",
    :QuestDescription => "A musician was feeling down because he thinks no one likes his music. I should help him drum up some business."
  }
  
  Quest9 = {
    :ID => "9",
    :Name => "Got any grapes?",
    :QuestGiver => "Duck",
    :Stage1 => "Listen to The Duck Song.",
    :Stage2 => "Try not to sing it all day.",
    :Location1 => "YouTube",
    :QuestDescription => "Let's try to revive old memes by listening to this funny song about a duck wanting grapes.",
    :RewardString => "A loss of braincells. Hurray!"
  }
  
  Quest10 = {
    :ID => "10",
    :Name => "Singing in the rain",
    :QuestGiver => "Some old dude",
    :Stage1 => "I've run out of things to write.",
    :Stage2 => "If you're reading this, I hope you have a great day!",
    :Location1 => "Somewhere prone to rain?",
    :QuestDescription => "Whatever you want it to be.",
    :RewardString => "Wet clothes."
  }
  
  Quest11 = {
    :ID => "11",
    :Name => "When is this list going to end?",
    :QuestGiver => "Me",
    :Stage1 => "When IS this list going to end?",
    :Stage2 => "123",
    :Stage3 => "456",
    :Stage4 => "789",
    :QuestDescription => "I'm losing my sanity.",
    :RewardString => "nil"
  }
  
  Quest12 = {
    :ID => "12",
    :Name => "The laaast melon",
    :QuestGiver => "Some stupid dodo",
    :Stage1 => "Fight for the last of the food.",
    :Stage2 => "Don't die.",
    :Location1 => "A volcano/cliff thing?",
    :Location2 => "Good advice for life.",
    :QuestDescription => "Tea and biscuits, anyone?",
    :RewardString => "Food, glorious food!"
  }
  
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
    :RewardString => "Rare Item"
  }
  
Powerplant = {
    :ID => "18",
    :Name => "The Powerplant",
    :QuestGiver => "Pokémon Encyclopedia",
    :Stage1 => "Investigate why Team Rocket is in Bouldergrove.",
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
    :Stage1 => "Find a way to smash rocks.",
    :Location1 => "Bouldergrove City",
    :QuestDescription => "A coalmine in the north of Bouldergrove has collapsed, with a way to clear the rocks, you could explore it.",
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
    :Stage1 => "Investigate the Game Corner and surrounding area.",
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
    :Location1 => "Emberton City PKMN Center",
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
    :Stage1 => "Trade a Manectric for a Exeggutor",
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
    :QuestDescription => "A missing link has been discovered in regards to accessing the ruins in Origin Valley!",
    :RewardString => "Legendary Encounter"
  }
  
POLIWAG = {
    :ID => "37",
    :Name => "TRADE: Pidgey for Poliwag",
    :QuestGiver => "Fat Guy",
    :Stage1 => "Trade a Pidgey for a Poliwag",
    :Location1 => "Trident Cove PKMN Center",
    :QuestDescription => "A trainer wants to trade Pokémon with you. Your Pidgey for his Poliwag.",
    :RewardString => "Poliwag"
  }

CHARMELEON = {
    :ID => "38",
    :Name => "TRADE: Pikachu for Charmeleon",
    :QuestGiver => "Lass",
    :Stage1 => "Trade a Pikachu for a Charmeleon",
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
    :Stage1 => "Bring Popping Candy to Dunsparce",
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
end

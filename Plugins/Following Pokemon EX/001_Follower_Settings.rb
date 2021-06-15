module FollowerSettings
  # Common event that contains "pbTalkToFollower" in  a script command
  # Change this if you are not using the CommonEvents.rxdata provided in the script.
  FOLLOWER_COMMON_EVENT         = 5

  # Animation IDs from followers
  # Change this if you are not using the Animations.rxdata provided in the script.
  Animation_Come_Out  = 30
  Animation_Come_In   = 29
  Emo_Happy           = 10
  Emo_Normal          = 13
  Emo_Hate            = 15
  Emo_Poison          = 17
  Emo_sing            = 12
  Emo_love            = 9

  # Allow the player to toggle followers on/off by pressing a key
  ALLOW_TOGGLE_FOLLOW = true
  # The key the player needs to press to toggle followers. :JUMPUP is the A key by default
  TOGGLE_FOLLOWER_KEY = :AUX2

  #Status tones to be used, if this is true (Red,Green,Blue,Gray)
  APPLY_STATUS_TONES  = false
  TONE_BURN           = [204,51,51,50]
  TONE_POISON         = [153,102,204,50]
  TONE_PARALYSIS      = [255,255,153,50]
  TONE_FROZEN         = [153,204,204,50]
  TONE_SLEEP          = [0,0,0,50]
  # For your custom status conditions, just add it as "TONE_(INTERNAL NAME)"
  # Example: TONE_BLEED, TONE_CONFUSE, TONE_INFATUATION

  # Time Taken for Follower to increase Friendship when first in party (in seconds)
  FRIENDSHIP_TIME_TAKEN = 125
  # Time Taken for Follower to find an item when first in party (in seconds)
  ITEM_TIME_TAKEN       = 5

  # List of Pokemon that will always appear behind the player when surfing
  # Doesn't include any flying or water types because those are handled already
  SURFING_FOLLOWERS = [
    # Gen 1
    :BEEDRILL, :VENOMOTH, :ABRA, :GEODUDE, :MAGNEMITE, :GASTLY, :HAUNTER,
    :KOFFING, :WEEZING, :PORYGON, :MEWTWO, :MEW,
    # Gen 2
    :MISDREAVUS, :UNOWN, :PORYGON2, :CELEBI,
    # Gen 3
    :DUSTOX, :SHEDINJA, :MEDITITE, :VOLBEAT, :ILLUMISE, :FLYGON, :LUNATONE,
    :SOLROCK, :BALTOY, :CLAYDOL, :CASTFORM, :SHUPPET, :DUSKULL, :CHIMECHO,
    :GLALIE, :BELDUM, :METANG, :LATIAS, :LATIOS, :JIRACHI,
    # Gen 4
    :MISMAGIUS, :BRONZOR, :BRONZONG, :SPIRITOMB, :CARNIVINE, :MAGNEZONE,
    :PORYGONZ, :PROBOPASS, :DUSKNOIR, :FROSLASS, :ROTOM, :UXIE, :MESPRIT,
    :AZELF, :GIRATINA, :CRESSELIA, :DARKRAI,
    # Gen 5
    :MUNNA, :MUSHARNA, :YAMASK, :COFAGRIGUS, :SOLOSIS, :DUOSION, :REUNICLUS,
    :VANILLITE, :VANILLISH, :VANILLUXE, :ELGYEM, :BEHEEYEM, :LAMPENT,
    :CHANDELURE, :CRYOGONAL, :HYDREIGON, :VOLCARONA, :RESHIRAM, :ZEKROM,
    # Gen 6
    :SPRITZEE, :DRAGALGE, :CARBINK, :KLEFKI, :PHANTUMP, :DIANCIE, :HOOPA,
    # Gen 7
    :VIKAVOLT, :CUTIEFLY, :RIBOMBEE, :COMFEY, :DHELMISE, :TAPUKOKO, :TAPULELE,
    :TAPUBULU, :COSMOG, :COSMOEM, :LUNALA, :NIHILEGO, :KARTANA, :NECROZMA,
    :MAGEARNA, :POIPOLE, :NAGANADEL,
    # Gen 8
    :ORBEETLE, :FLAPPLE, :SINISTEA, :POLTEAGEIST, :FROSMOTH, :DREEPY, :DRAKLOAK,
    :DRAGAPULT, :ETERNATUS, :REGIELEKI, :REGIDRAGO, :CALYREX
  ]

  # List of Pokemon that will not appear behind the player when surfing,
  # regardless of whether they are flying type, have levitate or are mentioned
  # in the SURFING_FOLLOWERS.
  SURFING_FOLLOWERS_EXCEPTIONS = [
    # Gen I
    :CHARIZARD, :PIDGEY, :SPEAROW, :FARFETCHD, :DODUO, :DODRIO, :SCYTHER,
    :ZAPDOS_1,
    # Gen II
    :NATU, :XATU, :MURKROW, :DELIBIRD,
    # Gen III
    :TAILLOW, :VIBRAVA, :TROPIUS,
    # Gen IV
    :STARLY, :HONCHKROW, :CHINGLING, :CHATOT, :ROTOM_1, :ROTOM_2, :ROTOM_3,
    :ROTOM_5, :SHAYMIN_1, :ARCEUS_2,
    # Gen V
    :ARCHEN, :DUCKLETT, :EMOLGA, :EELEKTRIK, :EELEKTROSS, :RUFFLET, :VULLABY,
    :LANDORUS_1,
    # Gen VI
    :FLETCHLING, :HAWLUCHA,
    # Gen VII
    :ROWLET, :DARTRIX, :PIKIPEK, :ORICORIO, :SILVALLY_2,
    # Gen VIII
    :ROOKIDEE
  ]
end
#===============================================================================
# DO NOT TOUCH THIS UNDER ANY CIRCUMSTANCES
#===============================================================================
class FollowerEvent < Event
  def trigger(*arg)
    for callback in @callbacks
      ret = callback.call(*arg)
      return ret if ret == true || ret == false
    end
    return -1
  end
end

module Events
  @@OnTalkToFollower = FollowerEvent.new
  def self.OnTalkToFollower;     @@OnTalkToFollower;     end
  def self.OnTalkToFollower=(v); @@OnTalkToFollower = v; end

  @@FollowerRefresh = FollowerEvent.new
  def self.FollowerRefresh;     @@FollowerRefresh;     end
  def self.FollowerRefresh=(v); @@FollowerRefresh = v; end
end

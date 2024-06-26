#===============================================================================
#
#===============================================================================
class PokemonTrainerCard_Scene
  def pbUpdate
    pbUpdateSpriteHash(@sprites)
  end

  def pbStartScene
    @viewport = Viewport.new(0,0,Graphics.width,Graphics.height)
    @viewport.z = 99999
    @sprites = {}
    background = pbResolveBitmap(sprintf("Graphics/Pictures/Trainer Card/bg_f"))
    if $Trainer.female? && background
      addBackgroundPlane(@sprites,"bg","Trainer Card/bg_f",@viewport)
    else
      addBackgroundPlane(@sprites,"bg","Trainer Card/bg",@viewport)
    end
    cardexists = pbResolveBitmap(sprintf("Graphics/Pictures/Trainer Card/card_f"))
    @sprites["card"] = IconSprite.new(0,0,@viewport)
    if $Trainer.female? && cardexists
	  case $Trainer.badge_count
	  when 0..2
      @sprites["card"].setBitmap("Graphics/Pictures/Trainer Card/card_f")
	  when 3..4
	  @sprites["card"].setBitmap("Graphics/Pictures/Trainer Card/card_f_1")
	  when 5..6
	  @sprites["card"].setBitmap("Graphics/Pictures/Trainer Card/card_f_2")
	  when 7..10
		if $Trainer.pokedex.owned_count >= 350
		@sprites["card"].setBitmap("Graphics/Pictures/Trainer Card/card_f_4")
		else
		@sprites["card"].setBitmap("Graphics/Pictures/Trainer Card/card_f_3")
		end
	  end
    else
	  case $Trainer.badge_count
	  when 0..2
      @sprites["card"].setBitmap("Graphics/Pictures/Trainer Card/card")
	  when 3..4
	  @sprites["card"].setBitmap("Graphics/Pictures/Trainer Card/card_1")
	  when 5..6
	  @sprites["card"].setBitmap("Graphics/Pictures/Trainer Card/card_2")
	  when 7..10
		if $Trainer.pokedex.owned_count >= 350
		@sprites["card"].setBitmap("Graphics/Pictures/Trainer Card/card_4")
		else
		@sprites["card"].setBitmap("Graphics/Pictures/Trainer Card/card_3")
		end
	  end
    end
    @sprites["overlay"] = BitmapSprite.new(Graphics.width,Graphics.height,@viewport)
    pbSetSystemFont(@sprites["overlay"].bitmap)
	@sprites["difficulty"] = IconSprite.new(406,4,@viewport)
	@sprites["nuzlocke"] = IconSprite.new(334,20,@viewport)
	case $PokemonSystem.difficulty
		when 0
			@sprites["difficulty"].setBitmap("Graphics/Pictures/Common/33v3")
		when 1
			@sprites["difficulty"].setBitmap("Graphics/Pictures/Common/M3W")
		when 2
			@sprites["difficulty"].setBitmap("Graphics/Pictures/Common/BGkdl")
		when 3
			@sprites["difficulty"].setBitmap("Graphics/Pictures/Common/H7aZ")
	end
	if $game_switches[176] == true
		@sprites["nuzlocke"].setBitmap("Graphics/Pictures/Common/NLzz3")
	end
    @sprites["trainer"] = IconSprite.new(336,112,@viewport)
    @sprites["trainer"].setBitmap(GameData::TrainerType.player_front_sprite_filename($Trainer.trainer_type))
    @sprites["trainer"].x -= (@sprites["trainer"].bitmap.width-128)/2
    @sprites["trainer"].y -= (@sprites["trainer"].bitmap.height-134)
    @sprites["trainer"].z = 2
    pbDrawTrainerCardFront
    pbFadeInAndShow(@sprites) { pbUpdate }
  end

  def pbDrawTrainerCardFront
    overlay = @sprites["overlay"].bitmap
    overlay.clear
    baseColor   = Color.new(72,72,72)
    shadowColor = Color.new(160,160,160)
    totalsec = Graphics.frame_count / Graphics.frame_rate
    hour = totalsec / 60 / 60
    min = totalsec / 60 % 60
    time = (hour>0) ? _INTL("{1}h {2}m",hour,min) : _INTL("{1}m",min)
    $PokemonGlobal.startTime = pbGetTimeNow if !$PokemonGlobal.startTime
    starttime = _INTL("{1} {2}, {3}",
       pbGetAbbrevMonthName($PokemonGlobal.startTime.mon),
       $PokemonGlobal.startTime.day,
       $PokemonGlobal.startTime.year)
    textPositions = [
       [_INTL("Name"),34,58,0,baseColor,shadowColor],
       [$Trainer.name,302,58,1,baseColor,shadowColor],
       [_INTL("ID No."),332,58,0,baseColor,shadowColor],
       [sprintf("%05d",$Trainer.public_ID),468,58,1,baseColor,shadowColor],
       [_INTL("Money"),34,106,0,baseColor,shadowColor],
       [_INTL("${1}",$Trainer.money.to_s_formatted),302,106,1,baseColor,shadowColor],
       [_INTL("Pokédex"),34,154,0,baseColor,shadowColor],
       [sprintf("%d/%d",$Trainer.pokedex.owned_count,$Trainer.pokedex.seen_count),302,154,1,baseColor,shadowColor],
       [_INTL("Time"),34,202,0,baseColor,shadowColor],
       [time,302,202,1,baseColor,shadowColor],
       [_INTL("Started"),34,250,0,baseColor,shadowColor],
       [starttime,302,250,1,baseColor,shadowColor]
    ]
    pbDrawTextPositions(overlay,textPositions)
    x = 72
    region = pbGetCurrentRegion(0) # Get the current region
    imagePositions = []
    for i in 0...8
      if $Trainer.badges[i+region*8]
        imagePositions.push(["Graphics/Pictures/Trainer Card/icon_badges",x,310,i*32,region*32,32,32])
      end
      x += 48
    end
    pbDrawImagePositions(overlay,imagePositions)
  end

  def pbTrainerCard
    pbSEPlay("GUI trainer card open")
    loop do
      Graphics.update
      Input.update
      pbUpdate
      if Input.trigger?(Input::BACK)
        pbPlayCloseMenuSE
        break
      end
    end
  end

  def pbEndScene
    pbFadeOutAndHide(@sprites) { pbUpdate }
    pbDisposeSpriteHash(@sprites)
    @viewport.dispose
  end
end

#===============================================================================
#
#===============================================================================
class PokemonTrainerCardScreen
  def initialize(scene)
    @scene = scene
  end

  def pbStartScreen
    @scene.pbStartScene
    @scene.pbTrainerCard
    @scene.pbEndScene
  end
end

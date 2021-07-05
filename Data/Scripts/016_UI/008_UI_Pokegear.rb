#===============================================================================
#
#===============================================================================
class PokegearButton < SpriteWrapper
  attr_reader :index
  attr_reader :name
  attr_reader :selected

  def initialize(command,x,y,viewport=nil)
    super(viewport)
    @image = command[0]
    @name  = command[1]
    @selected = false
    if $Trainer.female? && pbResolveBitmap(sprintf("Graphics/Pictures/Pokegear/icon_button_f"))
      @button = AnimatedBitmap.new("Graphics/Pictures/Pokegear/icon_button_f")
    else
      @button = AnimatedBitmap.new("Graphics/Pictures/Pokegear/icon_button")
    end
    @contents = BitmapWrapper.new(@button.width,@button.height)
    self.bitmap = @contents
    self.x = x
    self.y = y
    pbSetSystemFont(self.bitmap)
    refresh
  end

  def dispose
    @button.dispose
    @contents.dispose
    super
  end

  def selected=(val)
    oldsel = @selected
    @selected = val
    refresh if oldsel!=val
  end

  def refresh
    self.bitmap.clear
    rect = Rect.new(0,0,@button.width,@button.height/2)
    rect.y = @button.height/2 if @selected
    self.bitmap.blt(0,0,@button.bitmap,rect)
    textpos = [
       [@name,self.bitmap.width/2,4,2,Color.new(248,248,248),Color.new(40,40,40)],
    ]
    pbDrawTextPositions(self.bitmap,textpos)
    imagepos = [
       [sprintf("Graphics/Pictures/Pokegear/icon_"+@image),18,10]
    ]
    pbDrawImagePositions(self.bitmap,imagepos)
  end
end

#===============================================================================
#
#===============================================================================
class PokemonPokegear_Scene
  def pbUpdate
    for i in 0...@commands.length
      @sprites["button#{i}"].selected = (i==@index)
    end
    pbUpdateSpriteHash(@sprites)
  end

  def pbStartScene(commands)
    @commands = commands
    @index = 0
    @viewport = Viewport.new(0,0,Graphics.width,Graphics.height)
    @viewport.z = 99999
    @sprites = {}
    @sprites["background"] = IconSprite.new(0,0,@viewport)
    if $Trainer.female? && pbResolveBitmap(sprintf("Graphics/Pictures/Pokegear/bg_f"))
      @sprites["background"].setBitmap("Graphics/Pictures/Pokegear/bg_f")
    else
      @sprites["background"].setBitmap("Graphics/Pictures/Pokegear/bg")
    end
    for i in 0...@commands.length
      y = 196 - (@commands.length*24) + (i*48)
      @sprites["button#{i}"] = PokegearButton.new(@commands[i],118,y,@viewport)
    end
    pbFadeInAndShow(@sprites) { pbUpdate }
  end

  def pbScene
    ret = -1
    loop do
      Graphics.update
      Input.update
      pbUpdate
      if Input.trigger?(Input::BACK)
        pbPlayCloseMenuSE
        break
      elsif Input.trigger?(Input::USE)
        pbPlayDecisionSE
        ret = @index
        break
      elsif Input.trigger?(Input::UP)
        pbPlayCursorSE if @commands.length>1
        @index -= 1
        @index = @commands.length-1 if @index<0
      elsif Input.trigger?(Input::DOWN)
        pbPlayCursorSE if @commands.length>1
        @index += 1
        @index = 0 if @index>=@commands.length
      end
    end
    return ret
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
class PokemonPokegearScreen
  def initialize(scene)
    @scene = scene
  end

  def pbStartScreen
    commands = []
    cmdMap     = -1
    cmdPhone   = -1
    cmdJukebox = -1
    cmdEncounters = -1
    cmdClock = -1
	cmdCards = -1
    t=pbGetTimeNow.strftime("%I:%M %p")
    commands[cmdMap = commands.length]     = ["map",_INTL("Map")]
    if $PokemonGlobal.phoneNumbers && $PokemonGlobal.phoneNumbers.length>0
      commands[cmdPhone = commands.length] = ["phone",_INTL("Phone")]
    end
    commands[cmdJukebox = commands.length] = ["jukebox",_INTL("Jukebox")]
    commands[cmdEncounters = commands.length] = ["encounter",_INTL("Encounters")]
    commands[cmdClock = commands.length] = ["clock",_INTL("{1}",t)]
    @scene.pbStartScene(commands)
    loop do
      cmd = @scene.pbScene
      if cmd<0
        break
      elsif cmdMap>=0 && cmd==cmdMap
        pbShowMap(-1,false)
      elsif cmdPhone>=0 && cmd==cmdPhone
        pbFadeOutIn {
          PokemonPhoneScene.new.start
        }
      elsif cmdJukebox>=0 && cmd==cmdJukebox
        pbFadeOutIn {
          scene = PokemonJukebox_Scene.new
          screen = PokemonJukeboxScreen.new(scene)
          screen.pbStartScreen
        }
      elsif cmdEncounters>=0 && cmd==cmdEncounters
        pbFadeOutIn {
        scene = EncounterList_Scene.new
        screen = EncounterList_Screen.new(scene)
        screen.pbStartScreen
        }
      elsif cmdClock>=0 && cmd=cmdClock
        t=pbGetTimeNow.strftime("%I:%M %p")
        Kernel.pbMessage(_INTL("It is currently {1}. One hour in-game is equal to five minutes in real-time.",t))
      end
    end
    @scene.pbEndScene
  end
end

#-------------------------------------------------------------------------------
#  Dig
#-------------------------------------------------------------------------------
EliteBattle.defineMoveAnimation(:DIG) do
  if @hitNum == 1
    EliteBattle.playMoveAnimation(:DIG_DOWN, @scene, @userIndex, @targetIndex)
  elsif @hitNum == 0
    EliteBattle.playMoveAnimation(:DIG_UP, @scene, @userIndex, @targetIndex)
  end
end

EliteBattle.defineMoveAnimation(:DIG_DOWN) do
  usersprite = @userSprite
    targetsprite = @targetSprite
    player = @userIndex
	defaultvector = EliteBattle.get_vector(:MAIN, @battle)
    vector = @scene.getRealVector(@userIndex, @userIsPlayer)
    factor = @targetIsPlayer ? 2 : 1.5
    # set up animation
    fp = {}
    randx = []
    randy = []
    speed = []
    angle = []
    for m in 0...4
      randx.push([]); randy.push([]); speed.push([]); angle.push([])
        targetsprite = @sprites["pokemon#{m}"]
        next if !usersprite || usersprite.disposed? || usersprite.fainted || !usersprite.visible
      next if m == @userIndex
      for j in 0...32
        fp["#{j}#{m}"] = Sprite.new(@viewport) #usersprite
        fp["#{j}#{m}"].bitmap = pbBitmap("Graphics/Animations/eb223")
        fp["#{j}#{m}"].ox = fp["#{j}#{m}"].bitmap.width/2
        fp["#{j}#{m}"].oy = fp["#{j}#{m}"].bitmap.height/2
        fp["#{j}#{m}"].z = 50
        z = [0.5,0.4,0.3,0.7][rand(4)]
        fp["#{j}#{m}"].zoom_x = z
        fp["#{j}#{m}"].zoom_y = z
        fp["#{j}#{m}"].visible = false
        randx[m].push(rand(82)+(rand(2)==0 ? 82 : 0))
        randy[m].push(rand(32)+32)
        speed[m].push(4)
        angle[m].push((rand(8)+1)*(rand(2)==0 ? -1 : 1))
      end
    end
    # start animation
    @vector.set(vector)
  @scene.wait(20,true)
   factor = usersprite.zoom_x
    k = -1
#
    pbSEPlay("Anim/Earth4")
    for i in 0...92
      for m in 0...4
      targetsprite = @sprites["pokemon#{m}"]
      next if !usersprite || usersprite.disposed? || usersprite.fainted || !usersprite.visible
        next if m == @userIndex
        cx, cy = @userSprite.getCenter
        for j in 0...32
          next if j>(i/2)
          if !fp["#{j}#{m}"].visible
            fp["#{j}#{m}"].visible = true
            fp["#{j}#{m}"].x = cx - 82*usersprite.zoom_x + randx[m][j]*usersprite.zoom_x
            fp["#{j}#{m}"].y = usersprite.y
            fp["#{j}#{m}"].zoom_x *= usersprite.zoom_x
            fp["#{j}#{m}"].zoom_y *= usersprite.zoom_y
          end
          fp["#{j}#{m}"].y -= speed[m][j]*2*usersprite.zoom_y
          speed[m][j] *= -1 if (fp["#{j}#{m}"].y <= usersprite.y - randy[m][j]*usersprite.zoom_y) || (fp["#{j}#{m}"].y >= usersprite.y)
          fp["#{j}#{m}"].opacity -= 35 if speed[m][j] < 0
          fp["#{j}#{m}"].angle += angle[m][j]
        end
      end
      usersprite.zoom_x -= 0.2/6 if usersprite.zoom_x > factor
      usersprite.zoom_y += 0.2/6 if usersprite.zoom_y < factor
      
      k *= -1 if i%3==0
      if i%32==0
        pbSEPlay("Anim/Earth4")
        usersprite.zoom_x = factor*1.2
        usersprite.zoom_y = factor*0.8
      end
      @scene.wait(1,false)
    end
    #usersprite.visible = false
    #usersprite.hidden = true
    pbDisposeSpriteHash(fp)
    @vector.set(defaultvector)
    @scene.wait(20,true)
    #return true
  end

EliteBattle.defineMoveAnimation(:DIG_UP) do
    usersprite = @userSprite
    targetsprite = @targetSprite
    player = @userIndex
	defaultvector = EliteBattle.get_vector(:MAIN, @battle)
    vector = @scene.getRealVector(@targetIndex, @userIsPlayer)
   # inital configuration
    @itself = (@userIndex==@targetIndex)
    factor = @targetSprite.zoom_x
    #factor = player ? 2 : 1.5
    @vector.set(@scene.getRealVector(@targetIndex,@userIsPlayer))
    @scene.wait(16,true)
    # set up animation
    fp = {}
    rndx = []
    rndy = []
    for i in 0...16
      fp["#{i}"] = Sprite.new(@viewport) #target sprite
      fp["#{i}"].bitmap = pbBitmap("Graphics/Animations/eb024")
      fp["#{i}"].ox = 6
      fp["#{i}"].oy = 6
      fp["#{i}"].opacity = 0
      fp["#{i}"].z = 50
      r = rand(3)
      fp["#{i}"].zoom_x = (targetsprite.zoom_x)*(r==0 ? 1 : 0.5)
      fp["#{i}"].zoom_y = (targetsprite.zoom_y)*(r==0 ? 1 : 0.5)
      fp["#{i}"].tone = Tone.new(60,60,60)
      rndx.push(rand(128))
      rndy.push(rand(128))
    end
    factor = 1
    frame = Sprite.new(@viewport) #target sprite
    frame.z = 50
    frame.bitmap = pbBitmap("Graphics/Animations/eb520")
    frame.src_rect.set(0,0,114,114)
    frame.ox = 57
    frame.oy = 57
    frame.zoom_x = 0.5*factor
    frame.zoom_y = 0.5*factor
    frame.x, frame.y = @targetSprite.getCenter
    frame.opacity = 0
    frame.tone = Tone.new(255,255,255)
    # start animation
    for i in 1..30
      if i == 6
	    pbSEPlay("Anim/Earth3")
        pbSEPlay("Anime/Earth5")
      end
      if i.between?(1,5)
        targetsprite.still
        targetsprite.zoom_y-=0.05*factor
        targetsprite.toneAll(-12.8)
        frame.zoom_x += 0.1*factor
        frame.zoom_y += 0.1*factor
        frame.opacity += 51
      end
      frame.tone = Tone.new(0,0,0) if i == 6
      if i.between?(6,10)
        targetsprite.still
        targetsprite.zoom_y+=0.05*factor
        targetsprite.toneAll(+12.8)
        frame.angle += 2
      end
      frame.src_rect.x = 114 if i == 10
      if i >= 10
        frame.opacity -= 25.5
        frame.zoom_x += 0.1*factor
        frame.zoom_y += 0.1*factor
        frame.angle += 2
      end
      for j in 0...16
        next if i < 6
        cx = frame.x; cy = frame.y
        if fp["#{j}"].opacity == 0 && fp["#{j}"].visible
          fp["#{j}"].x = cx
          fp["#{j}"].y = cy
        end
        x2 = cx - 64*targetsprite.zoom_x + rndx[j]*targetsprite.zoom_x
        y2 = cy - 64*targetsprite.zoom_y + rndy[j]*targetsprite.zoom_y
        x0 = fp["#{j}"].x
        y0 = fp["#{j}"].y
        fp["#{j}"].x += (x2 - x0)*0.2
        fp["#{j}"].y += (y2 - y0)*0.2
        fp["#{j}"].zoom_x += 0.01
        fp["#{j}"].zoom_y += 0.01
        fp["#{j}"].angle += 2
        if i < 20
          fp["#{j}"].tone.red -= 6; fp["#{j}"].tone.blue -= 6; fp["#{j}"].tone.green -= 6
        end
        if (x2 - x0)*0.2 < 1 && (y2 - y0)*0.2 < 1
          fp["#{j}"].opacity -= 51
        else
          fp["#{j}"].opacity += 51
        end
        fp["#{j}"].visible = false if fp["#{j}"].opacity <= 0
      end
	  @scene.wait(1,true)
    end
    #usersprite.hidden = false
    #usersprite.visible = true
    frame.dispose
    pbDisposeSpriteHash(fp)
    @vector.set(defaultvector)
    #return true
  end

maxBoost = 0
isStalled = false
lcdColor = rgbm(88/255,193/255,217/255,255/255)
local player = ui.MediaPlayer("profec.mp4")

local playIntro = true
player:play()
function playIntroSequence()
    display.image { image = player, pos = vec2(0,447), color = lcdColor, size = vec2(1024,512), uvStart = vec2(0,0), uvEnd = vec2(1, 1) }
    if player:ended() then
        playIntro = false
    end
end

local function coverDefaultNumbers()
    display.rect({
        pos = vec2(63,536),
        size = vec2(276,334),
        color = rgbm.colors.black
    })
    display.rect({
        pos = vec2(383,538),
        size = vec2(627,330),
        color = rgbm.colors.black
    })
    display.rect({
        pos = vec2(77,883),
        size = vec2(51,72),
        color = lcdColor
    })
    display.rect({
        pos = vec2(150,883),
        size = vec2(181,73),
        color = lcdColor
    })
end

local function drawBoost()
    display.text({
        text =  string.format("%03d",math.floor(car.turboBoost*100)),
        pos = vec2(15,515),
        letter = vec2(400,420),
        font = 'profec',
        color =lcdColor,
        alignment = 1,
        width = 200,
        spacing = -70
    })
end

local function drawMaxBoost()
    maxBoost = math.max(maxBoost, math.floor(car.turboBoost*100))

    display.text({
        text = string.format("%03d",maxBoost),
        pos = vec2(51,880),
        letter = vec2(100,90),
        font = 'profec',
        color = rgbm.colors.black,
        alignment = 1,
        width = 200,
        spacing = -10
    })
end

function script.update(dt)
    if (car.rpm < 50) then
        display.rect { pos = vec2(0,447), color = rgbm.colors.black, size = vec2(1024,512) }
        player:play()
        playIntro = true
    elseif playIntro then
        maxBoost = 0
        playIntroSequence()
    else
        coverDefaultNumbers()
        drawBoost()
        drawMaxBoost()
    end
  end
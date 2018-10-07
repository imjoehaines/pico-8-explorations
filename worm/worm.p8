pico-8 cartridge // http://www.pico-8.com
version 16
__lua__
function _init()
  score = 0

  player = {
    x = 50,
    y = 50,
    sprite = 0,
    speed = 1,
    direction = 0
  }
  
  food = {
    x = flr(rnd(112)) + 8,
    y = flr(rnd(112)) + 8,
    sprite = 1
  }
end

function _update()
  if btn(0) then
    player.direction = 0
  elseif btn(1) then
    player.direction = 1
  elseif btn(2) then
    player.direction = 2
  elseif btn(3) then
    player.direction = 3
  end
  
  if player.direction == 0 then
    player.x -= player.speed
  elseif player.direction == 1 then
    player.x += player.speed
  elseif player.direction == 2 then
    player.y -= player.speed
  elseif player.direction == 3 then
    player.y += player.speed
  end
  
  if player.x < -8 then
    player.x = 128
  elseif player.x > 128 then
    player.x = 0
  elseif player.y < -8 then
    player.y = 128
  elseif player.y > 128 then
    player.y = 0
  end
  
  if player.x < food.x + 8
    and player.x + 8 > food.x
    and player.y < food.y + 8
    and player.y + 8 > food.y
  then
    food.x = flr(rnd(112)) + 8
    food.y = flr(rnd(112)) + 8
    score += 1
    player.speed += 0.1
  end
end

function _draw()
  cls()

  spr(
    player.sprite,
    player.x,
    player.y
  )

  spr(
    food.sprite,
    food.x,
    food.y
  )

  print("score: " .. score)
  print(player.x .. "," .. player.y, 0, 10)
  print(food.x .. "," .. food.y, 0, 20)
end

__gfx__
88888888003333000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
88888888033333300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
88888888333333330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
888888883b3333330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
888888883bb333330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
8888888833b333330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
88888888033333300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
88888888003333000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000

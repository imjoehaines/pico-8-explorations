pico-8 cartridge // http://www.pico-8.com
version 18
__lua__
music(0)

local padding = 4
local score = 0
local high_score = 0
local max_lives = 3
local lives = 3

local paddle = {
  x = 52,
  y = 119,
  width = 24,
  height = 4,
  colour = 1
}

function paddle:move(buttons)
  local left = band(buttons, 1) == 1

  if left and self.x > padding then
    self.x -= 3
  end
  
  local right = band(buttons, 2) == 2

  if right then
    local rightx = self.x + self.width
  
    if rightx < 127 - padding then
      self.x += 3
    end
  end
end

function paddle:draw()
  rectfill(
    self.x,
    self.y,
    self.x + self.width,
    self.y + self.height,
    self.colour
  )
end

local ball = {
  x = 64,
  y = 8,
  dx = 2,
  dy = -2,
  size = 4,
  colour = 13
}

function ball:move()
  if self.x < self.size or
    self.x > 127 - self.size
  then
    self.dx = -self.dx
    sfx(0)
  end
    
  if self.y < self.size then
    self.dy = -self.dy
    sfx(0)
  end
  
  self.x += self.dx
  self.y += self.dy
end

function ball:draw()
  circfill(
    self.x,
    self.y,
    self.size,
    self.colour
  )
end

function _init()
  cartdata(
    "imjoehaines_squashish"
  )
  
  high_score = dget(0)
end

function _update()
  if lives == 0 then
    return
  end

  paddle:move(btn())
  
  ball:move()
  
  -- ball hits paddle
  if ball.x >= paddle.x
    and ball.x <= paddle.x + paddle.width
    and ball.y > paddle.y - paddle.height
  then
    sfx(2)
    score += 1
    
    -- speed up ball every 5 points
    if score % 5 == 0 then
      ball.dx = min(
        8,
        ball.dx + 1
      )

      ball.dy = min(
        8,
        ball.dy + 1
      )
    end
    
    ball.dy = -ball.dy
  end
  
  -- ball falls out of bottom
  if ball.y > 128 then
    sfx(1)
    ball.y = flr(rnd(32))
    ball.x = flr(rnd(100)) + 10
    lives -= 1
    
    -- reset ball speed
    if flr(rnd(1)) == 1 then
      ball.dx = 2
    else
      ball.dx = -2
    end
    
    if flr(rnd(1)) == 1 then
      ball.dy = -2
    else
      ball.dy = 2
    end
  end
  
  -- if the player died this
  -- round and beat their high
  -- score, save it
  if lives == 0
    and score > high_score
  then
    high_score = score
    dset(0, high_score)
  end
end

function _draw()
  rectfill(
    0,
    0,
    127,
    127,
    6
  )
  
  for i = 1, max_lives do
    spr(
      0,
      90 + i * 8,
      padding
    )
  end
  
  for i = 1, lives do
    spr(
      1,
      90 + i * 8,
      padding
    )
  end
  
  paddle:draw()

  ball:draw()
  
  print(
    "score: " .. score,
    padding,
    padding,
    paddle.colour
  )
  
  if lives == 0 then
    print(
      "game over!",
      (127 / 2) - 20, -- 2 * string length
      (127 / 2) - 2.5, -- magic!
      paddle.colour
    )
    
    local score_string =
      "high score: " .. high_score
    
    print(
      score_string,
      (127 / 2) - #score_string * 2,
      (127 / 2) + 6,
      paddle.colour
    )
  end
end

__gfx__
08808800088088000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
80080080888888800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
80000080888888800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
08000800088888000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00808000008880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00080000000800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
010800002303001000170001a0001a0001a0001a000000001a0001a0001a0001a0001a0001b0001b0001b0001b0001b0000000000000000000000000000000000000000000000000000000000000000000000000
011000001d0331a033180330200103001030010000100001000010000100001000010000100001000013300100001000010000132001000010000100001000010000100001000010000100001000010000100001
010800001c03024030280300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
01100000290031d003110030000300003000030000300003000030000300003000030000300003000030000300003000030000300003000030000300003000030000300003000030000300003000030000300003
011000200c043006030060318000246151a0001f0001d0000c0431f000210000c003246150c0031f000110000c04313000150001d000246151f00021000180000c0431a0001f0000c043246150c0432100000000
011000200504505025050150504505025050150504505025050450502505015050450502505015050450502505045050250501505045050250501505045050250504505025050450502505045050250504505025
__music__
03 04054344


local res = {}
Bodies={}
local line_shape_index =1

function res.init_world(Pixel_meter_scale)
   Scale = Pixel_meter_scale
    love.physics.setMeter(Scale)
    World = love.physics.newWorld(0, 40*Scale, true)
    World:translateOrigin(1,1 )
    border = {}
    border.b = love.physics.newBody(World, 0,0, "static")
    local borderPoints = {
        0, 0,
        love.graphics.getWidth(), 0,
        love.graphics.getWidth(), love.graphics.getHeight(),
        0, love.graphics.getHeight(),
        0,0
    }
    border.s = love.physics.newChainShape(false, borderPoints)
    border.f = love.physics.newFixture(border.b, border.s)
    border.f:setUserData("border")
    table.insert(Bodies,border)
    test_obj()
    return World
end

function res.create_line_shape(coordinates)
    local coor = coordinates
    local m = 10* #coor
   print(m)
    obj={}

    obj.b = love.physics.newBody(World, 0,0, "dynamic")
    obj.b:setMass(m)
    obj.s = love.physics.newChainShape(false, coor)
    obj.f = love.physics.newFixture(obj.b, obj.s,4)
    obj.f:setUserData("line"..line_shape_index)
    obj.f:setRestitution(0.9)
    line_shape_index= line_shape_index + 1
    print(obj.b:getMass()   )
    table.insert(Bodies,obj)
end

function test_obj()
    
      
      --let's create a ball
  ball = {}
  ball.b = love.physics.newBody(World, 650/2, 650/2, "dynamic") --place the body in the center of the world and make it dynamic, so it can move around
  ball.s = love.physics.newCircleShape( 20) --the ball's shape has a radius of 20
  ball.f = love.physics.newFixture(ball.b, ball.s, 1) -- Attach fixture to body and give it a density of 1.
  ball.f:setRestitution(0.9) --let the ball bounce
  
--   table.insert(Bodies,ball)
  --let's create a couple blocks to play around with
  block1 = {}
  block1.b = love.physics.newBody(World, 200, 550, "dynamic")
  block1.s = love.physics.newRectangleShape(0, 0, 50, 100)
  block1.f = love.physics.newFixture(block1.b, block1.s, 5) -- A higher density gives it more mass.
  
--   table.insert(Bodies,block1)
  block2 = {}
  block2.b = love.physics.newBody(World, 200, 400, "dynamic")
  block2.s = love.physics.newRectangleShape(0, 0, 100, 50)
  block2.f = love.physics.newFixture(block2.b, block2.s, 2)
--   table.insert(Bodies,block2)
end
function res.update(dt)
    World:update(dt)
end

function res.render_world()
    love.graphics.push()  -- Save the current graphics state
    
    -- Translate to the position of the border body
    love.graphics.translate(border.b:getX(), border.b:getY())
    
    -- Scale to match the physics scaling factor
    love.graphics.scale(Scale)
    -- test 
    love.graphics.setColor(0.76, 0.18, 0.05)
    love.graphics.circle("fill", ball.b:getX(),ball.b:getY(), ball.s:getRadius())
  
    -- set the drawing color to grey for the blocks
    love.graphics.setColor(0.20, 0.20, 0.20)
    love.graphics.polygon("fill",block1.b:getWorldPoints(block1.s:getPoints()))
    love.graphics.polygon("fill",block2.b:getWorldPoints(block2.s:getPoints()))
    -- test 
    for _, body in ipairs(Bodies) do
        love.graphics.line( body.b:getWorldPoints(body.s:getPoints()))
    end
    love.graphics.pop()  -- Restore the graphics state
end
return res
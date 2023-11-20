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
    return World
end
function res.create_line_shape(coordinates)
    local coor = coordinates
    obj={}

    obj.b = love.physics.newBody(World, 0,0, "dynamic")
    print(coor[1].." | " ..coor[2])
    obj.b:setMass(10*#coor)
    obj.s = love.physics.newChainShape(false, coor)
    obj.f = love.physics.newFixture(obj.b, obj.s)
    obj.f:setUserData("line"..line_shape_index)
    line_shape_index= line_shape_index + 1
    print(obj.b:getX().. " | "..obj.b:getY())
    table.insert(Bodies,obj)
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
    for _, body in ipairs(Bodies) do
        love.graphics.line( body.b:getWorldPoints(body.s:getPoints()))
    end
    love.graphics.pop()  -- Restore the graphics state
end
return res
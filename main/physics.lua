local res = {}
Bodies={}
local line_shape_index =1

function res.init_world(Pixel_meter_scale)
    local scale = Pixel_meter_scale
    love.physics.setMeter(scale) 
    World = love.physics.newWorld(0, 9.81*scale, true)
    border = {}
    border.b = love.physics.newBody(World, 2,2, "static")
    local borderPoints = {
        0, 0,
        love.graphics.getWidth(), 0,
        love.graphics.getWidth(), love.graphics.getHeight(),
        0, love.graphics.getHeight(),
        0,0
    }
    border.s=""
    border.s = love.physics.newChainShape(false, borderPoints)
    border.f = love.physics.newFixture(border.b, border.s)
    border.f:setUserData("border")
    table.insert(Bodies,border)
    return World
end
function res.create_line_shape(coordinates)
    local coor = coordinates
    obj={}
    obj.b = love.physics.newBody(World, coor[1],coor[2], "dynamic")
    obj.s = love.physics.newChainShape(false, coor)
    obj.f = love.physics.newFixture(obj.b, obj.s)
    obj.f:setUserData("line"..line_shape_index)
    line_shape_index= line_shape_index + 1
    table.insert(Bodies,obj)
end

function res.render_world()
    for _, body in ipairs(Bodies) do
        love.graphics.polygon("line", body.b:getWorldPoints(body.s:getPoints()))
    end
end
return res
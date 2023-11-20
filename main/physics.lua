local res = {}

function res.init_world(Pixel_meter_scale)
    local scale = Pixel_meter_scale
    love.physics.setMeter(scale) 
    World = love.physics.newWorld(0, 9.81*scale, true)
    return World
end

function res.render_world()
    local bodies = World:getBodies()

    for index, body in ipairs(bodies) do
        love.graphics.polygon("line", body.b:getWorldPoints(body.s:getPoints()))
    end
  

end
return res
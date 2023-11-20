local phys = require("main.physics")
local draw = require("main.draw")
local entity = require("main.entity")
local coor = {}
function love.load()
    Environment = phys.init_world(1)
end 

function love.update(dt)
    coor.x, coor.y = love.mouse.getPosition()
        
    draw.build_char(coor.x,coor.y)
    draw.clear()
   phys.update(dt)

    
end

function love.mousereleased(x,y,button)
    if button == 1 then
        phys.create_line_shape(entity.create_line_shape_coordinates(draw.get_segments()))
      
        draw.Mouse_released()
    elseif button == 2 then
        draw.handle_right_click()
    end
end



function love.draw()

    draw.trace()
    phys.render_world()
end
local phys = require("main.physics")
local draw = require("main.draw")
local entity = require("main.entity")
local coor = {}
function love.load()
    Environment = phys.init_world(10)
end

function love.update(dt)
    coor.x, coor.y = love.mouse.getPosition()
        
    draw.build_char(coor.x,coor.y)
    draw.clear()
    
    Environment:update(dt)

    
end

function love.mousereleased(x,y,button)
    if button == 1 then
        entity.create_line_shape(Environment, draw.get_segments())
        for index, value in ipairs(Environment:getBodies()) do
            print(value:getX())
        end
        draw.Mouse_released()
    elseif button == 2 then
        draw.handle_right_click()
    end
end



function love.draw()

    draw.trace()
    -- phys.render_world()
end
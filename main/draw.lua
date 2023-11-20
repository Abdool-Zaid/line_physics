local res = {}
local char ={}
local segment ={}
local temp_line={}
local point_count =0
local p={x=-1,y=-1}
res.brush_size =4
res.arc=12
res.brush_color ={0.5,0.2,0.5}
function res.test()
    return "working"
end

function res.build_char(x,y)
    local yes = love.mouse.isDown(1)

    
    if yes==true then
        Build_temp(x,y)
                local newSquare = { x= x - res.brush_size / 2,y=  y - res.brush_size / 2 }
            table.insert(segment, newSquare)

        end
        
    end
  
    function res.Mouse_released()
        table.insert(char,segment)
       
        temp =segment
         segment={}
        Clear_temp()
end


function Draw_char()
    for i, segments in ipairs(char) do
        local int=1
        for j,square in ipairs(segments) do
            Draw_line(square.x,square.y)
            int =j
        end
       point_count=0
        
    end
end
function Check_points(x1,y1,x2,y2)
    
    if (x1==x2) and (y1==y2) then
        return false
    else
        return true
    end
end

function res.handle_right_click()
end

function Draw_line(Ix,Iy)
local x,y= Ix,Iy

    if point_count==0 then
        p.x,p.y=Ix,Iy
        point_count=1
    else
        
        if Check_points(x,y,p.x,p.y) == true then
            love.graphics.line(x,y,p.x,p.y)
            p.x,p.y=Ix,Iy
        end
        
    end
end

function Build_temp(x, y)
    love.graphics.setColor(res.brush_color[1],res.brush_color[2],res.brush_color[3])
    love.graphics.setLineWidth(res.brush_size)

    local newSquare = { x = x - res.brush_size / 2, y = y - res.brush_size / 2 }
    table.insert(temp_line, newSquare)
end


function Draw_temp()
    if #temp_line<2 then
    else

        for j =2, #temp_line, 1 do
            local  i = j-1
            if Check_points(temp_line[i].x,temp_line[i].y,temp_line[j].x,temp_line[j].y) == true then

                love.graphics.line(temp_line[i].x,temp_line[i].y,temp_line[j].x,temp_line[j].y)
            end

        end
    end
end
function res.get_segments()
    return segment
end

function res.trace()
    Draw_temp()
    -- Draw_char()
end

function Clear_temp()
    point_count=0
    temp_line={}
end

function res.clear()
    Clr = love.keyboard.isDown( "space" )
    if Clr==true then
        char= {}
        Clear_temp()
    end
end
return res

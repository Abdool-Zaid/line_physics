local res = {}
local line_shape_index =1
function localise_coor(coordinates)
    local coor = coordinates
    local output = {}

    table.insert(output,coor[1].x)
    table.insert(output,coor[1].y)

for i = 2, #coor, 1 do
    if (coor[i-1].x~=coor[i].x) or  (coor[i-1].y~=coor[i].y) then
        table.insert(output,coor[i].x)
        table.insert(output,coor[i].y)
    end
    
end
if #output<=2 then
    table.insert(output,(coor[1].x+1))
    table.insert(output,(coor[1].y+1))

end
return output

end


function res.world_border(world, border_name)
    local bname = border_name or "border"
    border = {}
border.b = love.physics.newBody(world, 1,1, "static")
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
border.f:setUserData(bname)
    return border
end

function res.create_line_shape(world ,coordinates)
    local coor = coordinates
    coor = localise_coor(coor)
    obj={}
    obj.b = love.physics.newBody(world, 1,1, "dynamic")
    obj.s=""
    obj.s = love.physics.newChainShape(false, coor)
    obj.f = love.physics.newFixture(obj.b, obj.s)
    obj.f:setUserData("line"..line_shape_index)
    line_shape_index= line_shape_index + 1
    
end
return res
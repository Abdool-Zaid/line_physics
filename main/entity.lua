local res = {}
function invert_line(tab)
    local n = #tab
    for i = n, 1, -2 do
        table.insert(tab, tab[i-3])
        table.insert(tab, tab[i-2])
    end
    print(#tab)
    
end

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




function res.create_line_shape_coordinates(coordinates)
    local coor = coordinates
    coor = localise_coor(coor)
    invert_line(coor)
   return coor
    
end
return res
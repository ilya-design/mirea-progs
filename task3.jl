function area(r::Robot)
    to_Sud =  moves!(r,Sud)
    to_West = moves!(r,West)

    side = Ost
    putmarkers!(r,side)
    while isborder(r,Nord)==false
        move!(r,Nord)
        side=HorizonSide(mod(Int(side)+2, 4))
        putmarkers!(r,side)
    end

    to_sup_side(r,Sud)
    to_sup_side(r,West)

    moves!(r,Ost,to_West)
    moves!(r,Nord,to_Sud)
end
function putmarkers!(r::Robot, side::HorizonSide)
    putmarker!(r)
    while isborder(r,side)==false
        move!(r,side)
        putmarker!(r)
    end    
end
#функция при которой вся линии помечается маркерами(включая первоначальную точку)
function to_sup_side(r::Robot,side::HorizonSide)
    while isborder(r,side)==false
        move!(r,side) 
    end
end
function moves!(r::Robot, side::HorizonSide)
    num_steps=0
    while isborder(r,side)==false
        move!(r,side)
        num_steps+=1
    end
    return num_steps
end
#функция,при которой считаются шаги до границы

function moves!(r::Robot,side::HorizonSide,num_steps::Int)
    for _ in 1:num_steps 
        move!(r,side)
    end
end
#функция,при которой робот идет до исходной точки 
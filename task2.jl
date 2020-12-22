function perimetr!(r::Robot) 

to_West = to_side!(r,West) 
to_Sud = to_side!(r,Sud) 
    
    for side in (Nord,Ost,Sud,West)
        putmarkers!(r,side)
    end
    
to_side!(r,Nord,to_Sud)
to_side!(r,Ost,to_West) 
    
end
#Робот ставит маркеры по периметру
       
function to_side!(r::Robot,side::HorizonSide) 
    num_steps=0
    while isborder(r,side) == false
        move!(r,side)
        num_steps+=1
    end
    return num_steps 
end
#на выходе получаем кол-во шагов по прямой до границы

function to_side!(r::Robot,side::HorizonSide,num_steps::Int) 
    for _ in (1:num_steps)
        move!(r,side)
    end
end
#используем кол-во шагов,чтобы вернуться в исходную точку

function putmarkers!(r::Robot, side::HorizonSide) 
    while isborder(r,side)==false
        move!(r,side)
        putmarker!(r)
    end
end
#ставим маркеры по линии до границы(в начале маркера нет)

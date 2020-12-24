#=ДАНО: Робот - в произвольной клетке ограниченного прямоугольной рамкой поля без внутренних перегородок и маркеров.

РЕЗУЛЬТАТ: Робот - в исходном положении в центре косого креста (в форме X) из маркеров.

(Подсказка: решение будет подобно решению задачи 1, если направление премещения Робота задавать кортежами пары значений типа HorizonSide)=#
#(r,HorizonSide(mod(Int(side)-1,4)))
#=function x_mark(r::Robot)
    for side in (HorizonSide(i) for i=0:3) # - перебор всех возможных направлений
        next_side=HorizonSide(mod(Int(side)+1,4))
        putmarkers!(r,side,next_side)
        move_by_markers(r,inverse(side),inverse(next_side))    
    end
    putmarker!(r)
end
function putmarkers!(r::Robot, side::HorizonSide,next_side::HorizonSide) 
    steps=0
    while !(isborder(r,side)==true ||  isborder(r,next_side)==true)==true
        moving!(r,side,next_side)
        putmarker!(r)
        steps+=1
    end
    return steps
end
function move_by_markers(r::Robot,side::HorizonSide,next_side::HorizonSide) 
    while ismarker(r)==true 
        moving!(r,side,next_side) 
    end       
end
function moving!(r::Robot,side::HorizonSide,next_side::HorizonSide)
    if isborder(r,side)==false &&  isborder(r,next_side)
        move!(r,side)
        move!(r,next_side)  
    end         
end 

inverse(side::HorizonSide) = HorizonSide(mod(Int(side)+2, 4)) 
=#
function mark_kross_x(r::Robot)
    for side in ((Nord,Ost),(Sud,Ost),(Sud,West),(Nord,West))
        putmarkers!(r,side)
        move_by_markers!(r,inverse(side))
    end
    putmarker!(r)
end

function putmarkers!(r::Robot,side::NTuple{2,HorizonSide})
    while isborder(r,side)==false 
        move!(r,side)
        putmarker!(r) 
    end
end

HorizonSideRobots.isborder(r::Robot,side::NTuple{2,HorizonSide}) = (isborder(r,side[1]) || isborder(r,side[2]))
 
HorizonSideRobots.move!(r::Robot, side::NTuple{2,HorizonSide}) = for s in side move!(r,s) end
# Здесь мы переопределяем одноименную стандартную команду Робота, определенную в модуле HorizonSideRobots 
# (важно, что в новом определении аргумент side имеет другой тип, отличный от соответствующего типа
# в стандартной команде), и поэтому в этом определении нам пришлось использовать составное имя: 
# HorizonSideRobots.move!

move_by_markers!(r::Robot,side::NTuple{2,HorizonSide}) = while ismarker(r) move!(r,side) end

inverse(side::NTuple{2,HorizonSide}) = (inverse(side[1]),inverse(side[2]))
inverse(side::HorizonSide)=HorizonSide(mod(Int(side)+2, 4))
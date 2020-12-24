#=ДАНО: Робот - в произвольной клетке ограниченного прямоугольной рамкой поля без внутренних перегородок и маркеров.

РЕЗУЛЬТАТ: Робот - в исходном положении в центре косого креста (в форме X) из маркеров.

(Подсказка: решение будет подобно решению задачи 1, если направление премещения Робота задавать кортежами пары значений типа HorizonSide)=#

function mark_kross_x(r::Robot)
    for side in ((Nord,Ost),(Nord,West),(Sud,West),(Sud,Ost))
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
#то же самое что и первое задание;отличие в измененной входной переменной(side->NTuple{2,HorizonSide})
HorizonSideRobots.isborder(r::Robot,side::NTuple{2,HorizonSide}) = (isborder(r,side[1]) || isborder(r,side[2]))
 
HorizonSideRobots.move!(r::Robot, side::NTuple{2,HorizonSide}) = for s in side move!(r,s) end
move_by_markers!(r::Robot,side::NTuple{2,HorizonSide}) = while ismarker(r) move!(r,side) end

inverse(side::NTuple{2,HorizonSide}) = (inverse(side[1]),inverse(side[2]))
inverse(side::HorizonSide)=HorizonSide(mod(Int(side)+2, 4))
#=NTuple{2,HorizonSide}-кортеж,где первый элемент-кол-во элементов,а второй тип элемента-стороны=#
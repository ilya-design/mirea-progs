#=ДАНО: На ограниченном внешней прямоугольной рамкой поле имеется ровно одна внутренняя перегородка в форме прямоугольника.
 Робот - в произвольной клетке поля между внешней и внутренней перегородками. 

 РЕЗУЛЬТАТ: Робот - в исходном положении и по всему периметру внутренней перегородки поставлены маркеры.=#
 function mark_between_border(r::Robot)
    num_steps_1=moves!(r,Sud)
    num_steps_2=moves!(r,West)
    num_steps_3=moves!(r,Sud)
#учитывается возможность изменения траектории из-за внутренней прямоугольной рамки

    find_border!(r,Ost,Nord)
    putmarker!(r)
    for side in (Nord,Ost,Sud,West)
        while isborder(r,HorizonSide(mod(Int(side)-1,4)))==true
            move!(r,side)
            putmarker!(r)
        end
        move!(r,HorizonSide(mod(Int(side)-1,4))) 
        putmarker!(r)   
    end   
 #проставляем маркеры по периметру прямоугольной рамки  
    
    back(r,Sud)
    back(r,West)
#возвращает в угол

    moves!(r,Nord,num_steps_3)
    moves!(r,Ost,num_steps_2)
    moves!(r,Nord,num_steps_1)
#возвращает в исходное положение   
end
function find_border!(r::Robot,side_to_border::HorizonSide, side_of_move::HorizonSide)  
    while isborder(r,side_to_border)==false  
        if isborder(r,side_of_move)==false
            move!(r,side_of_move)
        else
            move!(r,side_to_border)
            side_of_move=inverse(side_of_move)
        end
    end
end   
#=функция,при которой находится перегородка;входныепеременные:
робот,по какой линии смотреть(вертикальной или горизонтальной),какие перегородки ищем=#


function moves!(r::Robot, side::HorizonSide)
    num_steps=0
    while isborder(r,side)==false
        move!(r,side)
        num_steps+=1
    end
    return num_steps
end

function moves!(r::Robot,side::HorizonSide,num_steps::Int)
    for _ in 1:num_steps 
        move!(r,side)
    end
end

function back(r::Robot,side::HorizonSide)
    while isborder(r,side)==false
        move!(r,side)
    end    
end
#просто путь до границы

inverse(side::HorizonSide) = HorizonSide(mod(Int(side)+2, 4))

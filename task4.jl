#=ДАНО: Робот - Робот - в произвольной клетке ограниченного прямоугольного поля
   
   РЕЗУЛЬТАТ: Робот - в исходном положении, и клетки поля промакированы так: 
   нижний ряд - полностью, следующий - весь, за исключением одной последней клетки на Востоке, 
   следующий - за исключением двух последних клеток на Востоке, и т.д.
=#
function mountain!(r::Robot)
    to_Sud = moves!(r,Sud)
    to_West = moves!(r,West)
#по стандарту в левый нижний угол

   steps=putmarkers!(r,Ost) #нижняя линия в маркерах(робот в нижнем правом углу)
   back_moves!(r,West) #робот возвращаяется в левый угол
    while isborder(r,Nord)==false
       move!(r,Nord)
       putmarker!(r)
       steps-=1
       mark_part_line!(r,Ost,steps)
       back_moves!(r,West)
    end   
    if isborder(r,Nord)==true
        back_moves!(r,Sud)
    end    
#сначала маркеруется самая нижняя строчка,потом по while-end маркируются последующие строчки(на 1 клетку меньше)
#и под конец,если сверху перегородка-вернуться вниз         

   moves!(r,Nord,to_Sud)
   moves!(r,Ost,to_West)
#возвращаемся в исходную точку

end
function back_moves!(r::Robot,side::HorizonSide)
    while isborder(r,side)==false
        move!(r,side)
    end
end
function mark_part_line!(r::Robot,side::HorizonSide,steps::Int)
    for _ in 1:steps
        move!(r,side)
        putmarker!(r)
    end
end  
#маркеруем линию;на 1 меньше нижней

function putmarkers!(r::Robot, side::HorizonSide)
    steps=0
    putmarker!(r)
    while isborder(r,side)==false
        move!(r,side)
        steps+=1
        putmarker!(r)
    end    
    return steps
end
#функция при которой вся линии помечается маркерами(включая первоначальную точку)и выводится кол-во ячеек в линии

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
#в исходную точку
   

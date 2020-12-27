#=Робот - в произвольной клетке ограниченного прямоугольного поля, на котором могут находиться также внутренние прямоугольные перегородки 
в пятой задаче перегородки были изолированы-теперь перегородки могут быть любыми

РЕЗУЛЬТАТ: Робот - в исходном положении и в углах поля стоят маркеры=#
function mark_angles_but_harder(r::Robot)
    steps=0
    num_steps=[] 
    while isborder(r,Sud)==false && isborder(r,West)==false
        push!(num_steps,get_num_movements!(r,West)) 
        push!(num_steps,get_num_movements!(r,Sud))
        steps=steps+2 #сумма отрезков(образуют изгибы)
    end
    for side in (Nord,Ost,Sud,West)
        get_num_movements!(r,side)
        putmarker!(r)
    end
    while (steps>0)==true
        side=isodd(steps) ? Ost : Nord 
        for _ in 1:num_steps[steps]
            move!(r,side)
        end
        steps=steps-1
    end
end
    
function get_num_movements!(r::Robot, side::HorizonSide)
    num_steps=0
    while isborder(r,side)==false 
        move!(r,side) 
        num_steps+=1    
    end
    return num_steps
end 
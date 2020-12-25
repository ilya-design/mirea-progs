#=11)ДАНО: Робот - в произвольной клетке ограниченного прямоугольного поля, 
на котором могут находиться также внутренние прямоугольные перегородки 
(все перегородки изолированы друг от друга, прямоугольники могут вырождаться в отрезки)
РЕЗУЛЬТАТ: Робот - в исходном положении, и в 4-х приграничных клетках, две из которых имеют ту же широту, а две - ту же долготу, 
что и Робот, стоят маркеры.=#
#=
Примерный "движения" для решения задачи:
1)спускаться в Ю.З угол (аналогично с задачей про маркеры в углах) но сохранять кол-во шагов в массивах для West и Sud
2.1)Проходить вдоль внешней перегородки известное кол-во шагов и ставить маркеры
2.2)по известным кол-вам шагов из Ю.З можно пойти Ost,Nord потом вернуться обратно к углу и поменять направления
3)вернуться используя массив
=#


function ends_of_cross(r::Robot)
    num_steps=[] #создаём массив для num_steps
    to_West=0
    to_Sud=0
    while isborder(r,Sud)==false || isborder(r,West)==false 
        push!(num_steps, get_num_movements!(r, West))
        push!(num_steps, get_num_movements!(r, Sud))
    end
    #робот в ЮЗ углу;из массива в котором индексы и кол-во шагов
    #суммируем шаги проверяя индексы(нечётные-west,чётные-sud)
    for (i,n) in enumerate(num_steps)
        if isodd(i)
            to_West+=n
        else
            to_Sud+=n
        end    
    end
   marker_in_line(r,Nord,to_Sud)
   marker_in_line(r,Ost,to_West)
   moves!(r,Sud)
   moves!(r,West)
   marker_in_line(r,Ost,to_West)
   marker_in_line(r,Nord,to_Sud)
   moves!(r,West)
   moves!(r,Sud)

    for (i,n) in enumerate(num_steps)
        side = isodd(i) ? Ost : Nord 
        moves!(r,side,n)
    end
end
function marker_in_line(r::Robot,side::HorizonSide,num_steps::Int)#ставим один маркер(num_steps-параметр исходной точки)
    moves!(r,side,num_steps)
    putmarker!(r)
    moves!(r,side)
end    
function moves!(r::Robot, side::HorizonSide, num_steps::Int) 
    for _ in 1:num_steps
        move!(r,side)
    end
end
function moves!(r::Robot, side::HorizonSide) 
    while isborder(r,side)==false 
        move!(r,side) 
    end
end
function get_num_movements!(r::Robot, side::HorizonSide)
    num_steps = 0
    while isborder(r,side)==false 
        move!(r,side) 
        num_steps += 1    
    end
    return num_steps
end 

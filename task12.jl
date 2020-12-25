#=ЗАДАЧА:На прямоугольном поле произвольных размеров расставить маркеры в виде "шахматных" клеток,
 начиная с юго-западного угла поля, когда каждая отдельная "шахматная" клетка имеет размер n x n клеток поля (n - это параметр функции). 
 Начальное положение Робота - произвольное, конечное - совпадает с начальным. 
 Клетки на севере и востоке могут получаться"обрезанными" - зависит от соотношения размеров поля и "шахматных" клеток.
 (Подсказка: здесь могут быть полезными две глобальных переменных,
  в которых будут содержаться текущие декартовы координаты Робота относительно начала координат в левом нижнем углу поля, например)
=#
function chess(r::Robot)
    to_Sud=moves!(r,Sud)
    to_West=moves!(r,West)
    putmarker!(r)#маркер в углу
 
    num_steps_1=checking(r,Nord)
    back(r,Sud)
    num_steps_2=checking(r,Ost)
    back(r,West)
    if num_steps_1<num_steps_2
        steps=num_steps_1
    else
        steps=num_steps_2
    end  
        putmarkers!(r,Nord,steps)
        back(r,Sud)
        putmarkers!(r,Ost,steps)
        back(r,West)
    for i in 1:steps
        move!(r,Nord) 
        putmarkers!(r,Ost,steps)
        back(r,West)
    end
    back(r,Sud)
    
    moves!(r,Ost,to_West)
    moves!(r,Nord,to_Sud)
end
function check_of_marker(r::Robot,side::HorizonSide)#если робот на клетке с маркером-следующая-без(и наоборот)
     if ismarker(r)==true
        move!(r,side)
     else
        move!(r,side)
        putmarker!(r)
     end   
end    
function putmarkers!(r::Robot, side::HorizonSide,steps::Int) 
    for j in 1:steps
        check_of_marker(r,side)
    end
end
function checking(r::Robot,side::HorizonSide)
     num_steps=0
     while  isborder(r,side)==false
        move!(r,side)
        num_steps+=1
     end
    return num_steps 
end 
function back(r::Robot,side::HorizonSide) 
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

function moves!(r::Robot,side::HorizonSide,num_steps::Int)
    for _ in 1:num_steps 
        move!(r,side)
    end
end    
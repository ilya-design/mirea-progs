#=ДАНО: Робот - в произвольной клетке ограниченного прямоугольного поля (без внутренних перегородок)

РЕЗУЛЬТАТ: Робот - в исходном положении, в клетке с роботом стоит маркер, и все остальные клетки поля промаркированы в шахматном порядке=#
function chess(r)
    to_Sud=moves!(r,Sud)
    to_West=moves!(r,West)
    chess_parametr=to_Sud + to_West #сумма шагов до Ю.З. угла
    
    if iseven(chess_parametr)==true #если число чётное-угол маркеруется(исходная точка будет всегда промаркирована)
        putmarker!(r)
    end
    side = Ost
    putmarkers!(r,side)
    while isborder(r,Nord)==false
       if ismarker(r)==false 
        move!(r,Nord)
        putmarker!(r)
       else
        move!(r,Nord)
       end 
        side=HorizonSide(mod(Int(side)+2, 4))
        putmarkers!(r,side)
    end
    back(r,Sud)
    back(r,West)
    #принцип решения как в 3 задаче(некоторые функции изменены)

    moves!(r,Nord,to_Sud)
    moves!(r,Ost,to_West)
end    
function moves!(r::Robot, side::HorizonSide)
    num_steps=0
    while isborder(r,side)==false
        move!(r,side)
        num_steps+=1
    end
    return num_steps
end
function putmarkers!(r::Robot, side::HorizonSide) #функция-ставим маркеры в линию с чередованием(через клетку)
    while isborder(r,side)==false
        check_of_marker(r,side)
    end
end
function check_of_marker(r::Robot,side::HorizonSide)#если робот на клетке с маркером-следующая без маркера(и наоборот)
    if ismarker(r)==true
       move!(r,side)
    else
       move!(r,side)
       putmarker!(r)
    end   
end    
function back(r::Robot,side::HorizonSide) #возвращаемся к границам сторон
    while isborder(r,side)==false
        move!(r,side)
    end
end  
function moves!(r::Robot, side::HorizonSide, num_steps::Int) 
    for _ in 1:num_steps
        move!(r,side)
    end
end

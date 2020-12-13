function mark_frame_perimetr!(r::Robot)
    num_vert = moves!(r, Sud)
    num_hor = moves!(r, West)
    #УТВ: Робот - в Юго-Западном углу

    for sidе in (Nord, Ost, Sud, West)
        putmarkers!(r, side)
    end
    #УТВ: По всему периметру стоят маркеры

    moves!(r, Nord, num_vert)
    moves!(r, Ost, num_hor)
    #УТВ: Робот - в исходном положении
end

#функция,при которой робот считает кол-во шагов до стенки
function moves!(r::Robot, side::HorizonSide)
    num_steps=0
    while isborder(r,side)==false
        move!(r,side)
        num_steps+=1
    end
    return num_steps
end

#функция,при которой робот идет до исходной точки
function moves!(r::Robot,side::HorizonSide,num_steps::Int)
    for _ in 1:num_steps 
        move!(r,side)
    end
end


#если в стороне(которая подаётся как агрумент для функции)нет границы-идти до неё и параллельно проставлять маркеры
function putmarkers!(r::Robot, side::HorizonSide)
    while isborder(r,side)==false
        move!(r,side)
        putmarker!(r)
    end
end
#Функции moves! называются одинаково,но кол-во аргументов,которое они получают на вход-разное,поэтому julia разберётся

#=ДАНО: Робот - в произвольной клетке ограниченного прямоугольного поля
   +учитываются внутренние прямоугольные перегородки,которые изолированы друг от друга и от внешней перегородки
   РЕЗУЛЬТАТ: Робот - в исходном положении, и все клетки поля промакированы=#

   #=В данной задаче- из-за наличия перегородок- робот перемещается в ЮЗ угол другим способом(учитывающим перегородки) 
   Также имеет смысл изменить функцию putmarkers!(r,side) так,чтобы она учитывала перегородки на пути
   Таким образом главная функцию по виду отличается только способом передвижения из исходной точки к ЮЗ углу=#



function area_but_harder(r::Robot)
    num_steps=[] #создаём массив для num_steps
    while isborder(r,Sud)==false || isborder(r,West)==false 
        push!(num_steps, get_num_movements!(r, West))
        push!(num_steps, get_num_movements!(r, Sud))
    end
    #Робот в ЮЗ углу

    side=Ost
    putmarkers!(r,side)
    to_sup_side(r,West) #самая нижняя линия замаркерована и робот в ЮЗ углу 
    while isborder(r,Nord)==false #пока робот не поднялся полностью ставит маркеры и проверяет типы перегородок(внутренние,внешние)
        putmarker!(r)
        move!(r,Nord)
        count=1
        while count!=0
            putmarker!(r)
            count=workaround_wall(r,inverse(side))
            putmarker!(r)
        end
        side=inverse(side)
    end
    

    to_sup_side(r,Sud)
    to_sup_side(r,West)
    #робот в ЮЗ углу

    for (i,n) in enumerate(num_steps)
        side = isodd(i) ? Ost : Nord 
        moves!(r,side,n)
    end
end
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
#функция при которой вся линии помечается маркерами(включая первоначальную точку)

function to_sup_side(r::Robot,side::HorizonSide)
    while isborder(r,side)==false
        move!(r,side) 
    end
end
 
function workaround_wall(r::Robot, side::HorizonSide) #функция для обхода внутренних перегородок
    num_steps=0
    while isborder(r,side)==true && isborder(r,next(side))==false  #уходим от линии маркеров чтобы обойти перегородки
        move!(r,next(side))
        num_steps+=1
    end
    count=0 
    if isborder(r,side)==false
        move!(r,side)
        count+=1 #считаем шаги при движении по линии
    end
    if num_steps !=0
        while isborder(r,inverse(next(side)))==true #проходим перегородку на другой линии
            move!(r,side)
            count+=1
        end
        for t in 1:num_steps
        move!(r,inverse(next(side))) #возвращаемся на линию
        end
    end
    return count #Возвращение значения счётчика(сколько будет маркеров в линии)
    end

    function get_num_movements!(r::Robot, side::HorizonSide)
        num_steps = 0
        while isborder(r,side)==false 
            move!(r,side) 
            num_steps += 1    
        end
        return num_steps
    end 
    function moves!(r::Robot, side::HorizonSide, num_steps::Int) 
        for _ in 1:num_steps
            move!(r,side)
        end
    end


next(side::HorizonSide)= HorizonSide(mod(Int(side)+1,4))

inverse(side::HorizonSide)=HorizonSide(mod(Int(side)+2,4))

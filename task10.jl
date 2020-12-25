#=ДАНО: Робот - в юго-западном углу поля, на котором расставлено некоторое количество маркеров
РЕЗУЛЬТАТ: Функция вернула значение средней температуры всех замаркированных клеток=#
function average_temperature(r::Robot)
    sum_temperature=0
    num_temperature=0
    average_temperature=0
    side=Ost
    while isborder(r,side)==false
        if ismarker(r)==true
            sum_temperature+=temperature(r)#сумма- температур клеток(temperature-встроенная в HorizonSide функция)
            num_temperature+=1#кол-во маркеров
            move!(r,side)
        else
            move!(r,side)
        end
    end 
    #первая строчка пройдена

    side=HorizonSide(mod(Int(side)+2, 4))
    while isborder(r,Nord)==false
        move!(r,Nord)
        while isborder(r,side)==false
            if ismarker(r)==true
                sum_temperature+=temperature(r)
                num_temperature+=1
                move!(r,side)
            else
                move!(r,side)
            end
        end        
        side=HorizonSide(mod(Int(side)+2, 4))
    end
    #все строчки пройдены

    back(r,Sud)
    back(r,West)
    #Робот вернулся в угол

    if num_temperature==0
        return 0
    else
        average_temperature=sum_temperature/num_temperature
        return average_temperature
    end
end
function back(r::Robot,side::HorizonSide) #возвращаемся к границам сторон
    while isborder(r,side)==false
        move!(r,side)
    end
end  
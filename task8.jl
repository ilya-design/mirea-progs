#=ДАНО: Робот - рядом с горизонтальной перегородкой (под ней), бесконечно продолжающейся в обе стороны,
в которой имеется проход шириной в одну клетку.
РЕЗУЛЬТАТ: Робот - в клетке под проходом=#

function search_passage(r::Robot)
    steps=0
    side=Ost 
        while isborder(r,Nord)==true#увеличиваем шаги вправо и влево относительно исходной точки 
            steps+=1
            move_for_search(r,side,steps)
            steps+=1
            side=HorizonSide(mod(Int(side)+2, 4))
            move_for_search(r,side,steps)
        end        
end
function move_for_search(r::Robot,side::HorizonSide,steps::Int)#двигается на клетку если сверху перегородка(цикл)
    for _ in 1 : steps
        if isborder(r,Nord)==true
            move!(r,side)
        else
            break
        end    
    end    
end    

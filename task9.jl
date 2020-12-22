#=ДАНО: Где-то на неограниченном со всех сторон поле и без внутренних перегородок имеется единственный маркер.
 Робот - в произвольной клетке поля.
   РЕЗУЛЬТАТ: Робот - в клетке с тем маркером.=#
function find_marker(r)
    steps=1
    while ismarker(r)==false
        up_left_moves!(r,Nord,steps)
        steps+=1
        down_right_moves!(r,Sud,steps)
        steps+=1
    end
end  
function up_left_moves!(r::Robot,Nord::HorizonSide,steps::Int)
    for _ in 1:steps 
        if ismarker(r)==false
            move!(r,Nord)
        else
            break
        end
    end        
    for _ in 1:steps 
        if ismarker(r)==false
             move!(r,West)     
        end
    end
end
function down_right_moves!(r::Robot,Sud::HorizonSide,steps::Int)
    for _ in 1:steps 
        if ismarker(r)==false
            move!(r,Sud)
        else
            break 
        end    
    end        
    for _ in 1:steps 
        if ismarker(r)==false
             move!(r,Ost)
        end
    end
end
moves!(r::Robot, side::HorizonSide, num_steps::Int) = 
for _ in 1:num_steps
    move!(r,side)
end


function mark_frame_perimetr!(r::Robot)
    num_vert = moves!(r, Sud)
    num_hor = moves!(r, West)
    #Робот - в Юго-Западном углу

    for sidе in (HorizonSide(i);i=0:3) # (Nord, West, Sud, Ost)
        putmarkers!(r, side) 
    end 
    #По всему периметру стоят маркеры

    moves!(r, Nord, num_vert)
    moves!(r, Ost, num_hor)
    #Робот - в исходном положении
end

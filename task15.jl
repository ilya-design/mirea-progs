#=* ДАНО: Робот - в произвольной клетке поля (без внутренних перегородок и маркеров)
   +учитываются внутренние перегородки
   РЕЗУЛЬТАТ: Робот - в исходном положении, и все клетки по периметру внешней рамки промакированы=#
   include("roblib.jl")

function perimetr_harder(r)#аналогично 5-ой задчае,только теперь робот ставит маркеры вдоль внешней рамки,а не только в углах
    num_steps=[] 
    while isborder(r,Sud)==false || isborder(r,West)==false 
        push!(num_steps, get_num_movements!(r, West))
        push!(num_steps, get_num_movements!(r, Sud))
    end
   putmarker!(r)

    for side in (Nord,Ost,Sud,West)
      putmarkers!(r,side)  #замена movements!(r,side) putmarker!(r)на putmarkers    
    end

    for (i,n) in enumerate(num_steps)
        side = isodd(i) ? Nord : Ost 
        moves!(r,side,n)
    end
end
function moves!(r::Robot, side::HorizonSide, num_steps::Int) 
   for _ in 1:num_steps
       move!(r,side)
   end
end
function putmarkers!(r::Robot, side::HorizonSide) 
   while isborder(r,side)==false
       move!(r,side)
       putmarker!(r)
   end
end
   
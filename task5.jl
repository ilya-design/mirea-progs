#=Робот - в произвольной клетке ограниченного прямоугольного поля, на котором могут находиться также внутренние прямоугольные перегородки 
(все перегородки изолированы друг от друга, прямоугольники могут вырождаться в отрезки)

РЕЗУЛЬТАТ: Робот - в исходном положении и в углах поля стоят маркеры=#
include("roblib.jl")

function mark_angles(r)
    num_steps=[] #создаём массив для num_steps
    while isborder(r,Sud)==false || isborder(r,West)==false #по условию перегородки не могут соприкасаться->соприкосновение-в углах
        push!(num_steps, get_num_movements!(r, West))
        push!(num_steps, get_num_movements!(r, Sud))
    end
#=функция push! определена по умолчанию-она увеличивает кол-во элементов массива
то есть,если элементов было 4,то после get_num_movements! их стало 5(5 элементов где get_num_movements!-даёт 5-ый элемент) =#   

    for side in (Nord,Ost,Sud,West)
        movements!(r,side)
        putmarker!(r)
    end

    for (i,n) in enumerate(num_steps)
        side = isodd(i) ? Ost : Nord 
        movements!(r,side,n)
    end
#isodd(i::Int)-проверка числа на нечётность(true-если i-нечётный)
#iseven(i::Int)-аналогично,но для чётных
#функция enumerate-генерирует кортеж из 2 элементов(индекс и сам элемент)
end
function moves!(r,side)
    num_steps=0
    while isborder(r,side)==false
        move!(r,side)
        num_steps+=1
    end
    return num_steps
end
#уже стандартная функция для подсчёта шагов
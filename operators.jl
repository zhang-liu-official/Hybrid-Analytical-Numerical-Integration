
struct ExpPoly
    ExpList::Array{ComplexF64}
    CoeffList::Array{ComplexF64}
    function ExpPoly(ExpList::Array{ComplexF64}, CoeffList::Array{ComplexF64})
        if(length(ExpList) != length(CoeffList))
            error("Invalid Exponential Polynomial")
        end

        CheckList = Dict{ComplexF64, Int64}()
        #exponent + index (at the first time it appears)

        for i = 1:length(ExpList)
            if haskey(CheckList, ExpList[i])
                #if the same exponent already exists, add coefficient to the term where it first appears
                CoeffList[CheckList[ExpList[i]]] = CoeffList[CheckList[ExpList[i]]] + CoeffList[i]
                CoeffList[i] = 0
                #the next if-statement will later ignore this term
            else
                #create a new entry in the dictionary
                CheckList[ExpList[i]] = i
            end
        end
        for i = 1:length(CoeffList)
            if(CoeffList[i] == 0)
                deleteat!(CoeffList, i)
                deleteat!(ExpList,i)
            end
        end
        return new(ExpList, CoeffList)
    end
end

function Base.:+(x::ExpPoly, y::ExpPoly)
    return ExpPoly([x.ExpList; y.ExpList], [x.CoeffList; y.CoeffList])
end


function Base.:-(x::ExpPoly, y::ExpPoly)
    #change all coefficients of the second ExpPoly to negative
    for i = 1:length(y.CoeffList)
        y.CoeffList[i] = y.CoeffList[i] * (-1)
    end
    return ExpPoly([x.ExpList; y.ExpList], [x.CoeffList; y.CoeffList])
end

function Base.:*(x::ExpPoly, y::ExpPoly)
    z = ExpPoly(Array{ComplexF64,1}(undef, length(x.ExpList)*length(y.ExpList)), Array{ComplexF64,1}(undef, length(x.CoeffList)*length(y.CoeffList)))
    k = 1
    #print(length(x.ExpList)*length(y.ExpList))
    for i = 1:length(x.ExpList)
        for j = 1:length(y.ExpList)
            z.CoeffList[k] = x.CoeffList[i] * y.CoeffList[j]
            z.ExpList[k] = x.ExpList[i] + y.ExpList[j]
            k = k + 1
        end
    end
    return ExpPoly(z.ExpList, z.CoeffList)
end

#convert to julia function in simpy


a = ExpPoly([6.0+8.0im, 5.0+7.0im, 5.0+5.0im, 4.0+3.0im],[1.0+2.0im, 3.0+4.0im, 4.0+1.0im, 2.0+4.0im])
b = ExpPoly([6.0+8.0im],[2.0+2.0im])
print(a+b)
print(a-b)
print(a*b)
#=
a = ExpPoly([6.0+8.0im, 5.0+7.0im],[1.0+2.0im, 3.0+4.0im])
b = ExpPoly([6.0+8.0im, 3.0+2.0im],[2.0+2.0im, 5.0+8.0im])
=#

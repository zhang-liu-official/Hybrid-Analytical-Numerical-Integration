struct ExpPoly
    ExpList::Array{ComplexF64}
    CoeffList::Array{ComplexF64}
    function ExpPoly(ExpList::Array{ComplexF64}, CoeffList::Array{ComplexF64})
        if(length(ExpList) != length(b))
            error("Invalid Exponential Polynomial")
        end

        CheckList::Dict{ComplexF64, Int64}()
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

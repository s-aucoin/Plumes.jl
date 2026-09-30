export LazyPlumeLengthScale, LazyVirtualSourcePosition


#########################################
"""
    LazyPlumeLengthScale(b₀; α=0.11)
Calculate the distance from the actual source to the virtual source of a lazy plume from the source radius `b₀` and entrainment coefficient `α`.
"""
function LazyPlumeLengthScale(b₀; α=0.11)
    return 5/(6α) * b₀
end


"""
    LazyVirtualSourcePosition(Γ₀; N=10)

Calculate the virtual source position of a lazy plume with source parameter `Γ₀` including `N` terms in the series approximation.
"""
function LazyVirtualSourcePosition(Γ₀; N=10)
    
    sum_series = Array{Float64}(undef, N)
    for n in 1:N

        product_series = Array{Float64}(undef, n)
        for i in 1:n
            first_term = (-4/5 + i)/((n - 3/10)*factorial(n))
            second_term = ((Γ₀ - 1)/Γ₀)^n

            product_series[i] = first_term * second_term 
        end

        sum_series[n] = prod(product_series)
    end

    return Γ₀^(-1/5) * (sum(sum_series) - 10/3)
end
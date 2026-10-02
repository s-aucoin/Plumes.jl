using LsqFit

export LSFitPlumeW


#########################################
"""
    LSFitPlumeW(z, w, ρₐ; p0 = [0.1, 0.01, 0.999*ρₐ], α=0.11, g = 9.80665)

Least squares fit a theoretical plume velocity curve to `w` points at `z` in an ambient with density `ρₐ`.

The fit returns best fit coefficients [b₀, w₀, ρ₀] and `p0` is the vector of guesses for the fitting coefficients, `α`` is the entranment coefficient, and `g` is the gravitational acceleration.
"""
function LSFitPlumeW(z, w, ρₐ; p0 = [0.1, 0.01, 0.999*ρₐ], κ=2, α=0.11, g = 9.80665)

    Γ₀(b₀, w₀, ρ₀) = Γ₀Definition(b₀, w₀, ρ₀, ρₐ; κ, α, g)

    Γ(z, b₀, w₀, ρ₀) = ζ2Γ(z2ζ(z, b₀; α), Γ₀(b₀, w₀, ρ₀))

    LazyPlumeWBasicParameters(z, b₀, w₀, ρ₀) = LazyPlumeW(Γ(z, b₀, w₀, ρ₀), Γ₀(b₀, w₀, ρ₀), w₀)

    ## p[1] is b₀, p[2] is w₀, p[3] is ρ₀ ##
    fitmodel(z, p) = LazyPlumeWBasicParameters.(z, p[1], p[2], p[3])
    
    upper = [Inf, Inf, ρₐ]
    lower = [0.0, 0.0, 998.0]
    return curve_fit(fitmodel, z, w, p0; upper, lower)

end
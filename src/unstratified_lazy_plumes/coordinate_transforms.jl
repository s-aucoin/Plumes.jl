using Integrals
using NonlinearSolve

export z2ζ, ζ2z, Γ2ζ, ζ2Γ


#########################################
"""
    z2ζ(z, b₀; α=0.11)
Convert depth `z` to scaled plume height `ζ` using the source parameter `b₀` and the entrainment coefficient `α`.
"""
function z2ζ(z, b₀; α=0.11)
    return 6*α/5 * z / b₀
end


"""
    ζ2z(ζ, b₀; α=0.11)
Convert scaled plume height `ζ` to depth `z` using the source parameter `b₀` and the entrainment coefficient `α`.
"""
function ζ2z(ζ, b₀; α=0.11)
    return 5/6 * ζ * b₀ / α
end


###################
#=
"""
    Γ_integral(Γ, Γ₀)

Calculate the integral contained in equation 4.4 of Hunt and Kaye (2005) from a value of `Γ` and its source value `Γ₀`.

Optionally specify whether the to use the `:lazy` or `:forced` plume versions with `method`.
"""
function Γ_integral(Γ, Γ₀; method=:lazy)

    ## get the appropriate function for the integral ##
    method_name = Symbol("integrand_", method)
    f2integrate = getfield(Plumes, method_name)

    bounds = (Γ₀, Γ)
    ζ_prob = IntegralProblem(f2integrate, bounds)
    return solve(ζ_prob, QuadGKJL()).u
end

"""
    Γ2ζ(Γ, Γ₀; method=:lazy)

Calculate the height parameter `ζ` from a value of `Γ` and its source value `Γ₀`.

Optionally specify whether the to use the `:lazy` or `:forced` plume versions with `method`.
"""
function Γ2ζ(Γ, Γ₀; method=:lazy)

    ## get the appropriate function for the integral factor ##
    method_name = Symbol("integral_factor_", method)
    integral_factor = getfield(Plumes, method_name)

    return integral_factor(Γ₀) * Γ_integral(Γ, Γ₀; method)

end

"""
    ζ2Γ(ζ, Γ₀; uspan=[1.0001, Γ₀])

Calculate the plume parameter `Γ` for a height `ζ` and source plume parameter `Γ₀`.

Optionally specify whether the to use the `:lazy` or `:forced` plume versions with `method`.
"""
function ζ2Γ(ζ, Γ₀; uspan=[1.0001, Γ₀], method=:lazy)

    Γ_relation(Γ, p) = Γ2ζ(Γ, Γ₀; method) .- ζ

    prob2solve = IntervalNonlinearProblem(Γ_relation, uspan)
    return solve(prob2solve, FastShortcutNonlinearPolyalg(autodiff = AutoFiniteDiff())).u

end
=#

# redesign the functions so that you don't have to specify a method #
"""
    Γ_integral(Γ, Γ₀)

Calculate the integral contained in equation 4.4 of Hunt and Kaye (2005) from a value of `Γ` and its source value `Γ₀`.
"""
function Γ_integral(Γ, Γ₀)
    ## get the appropriate function for the integral ##
    if Γ₀ > 1.0
        f2integrate = integrand_lazy
    else
        f2integrate = integrand_forced
    end

    bounds = (Γ₀, Γ)
    ζ_prob = IntegralProblem(f2integrate, bounds)
    return solve(ζ_prob, QuadGKJL()).u
end

"""
    Γ2ζ(Γ, Γ₀)

Calculate the height parameter `ζ` from a value of `Γ` and its source value `Γ₀`.
"""
function Γ2ζ(Γ, Γ₀)
    ## get the appropriate function for the integral factor ##
    if Γ₀ > 1.0
        integral_factor = integral_factor_lazy
    else
        integral_factor = integral_factor_forced
    end

    return integral_factor(Γ₀) * Γ_integral(Γ, Γ₀)
end

"""
    ζ2Γ(ζ, Γ₀; ΔΓ = 0.0001)

Calculate the plume parameter `Γ` for a height `ζ` and source plume parameter `Γ₀`.
"""
function ζ2Γ(ζ, Γ₀; ΔΓ = 0.0001)

    Γ_relation(Γ, p) = Γ2ζ(Γ, Γ₀) .- ζ

    if Γ₀ > 1.0
        uspan = [1+ΔΓ, Γ₀]
    else
        uspan = [Γ₀, 1-ΔΓ]
    end

    prob2solve = IntervalNonlinearProblem(Γ_relation, uspan)
    return solve(prob2solve, FastShortcutNonlinearPolyalg(autodiff = AutoFiniteDiff())).u

end


# Definitions of the integrand for the ζ and Γ relationship #
integral_factor_lazy(Γ₀) = -3/10 * (Γ₀ - 1)^(3/10) * Γ₀^(-1/2)
integral_factor_forced(Γ₀) = 3/10 * (1 - Γ₀)^(3/10) * Γ₀^(-1/2)

integrand_lazy(Γ, p) = Γ^(-1/2) *(Γ - 1)^(-13/10) # for lazy plums
integrand_forced(Γ, p) = Γ^(-1/2) *(1 - Γ)^(-13/10) # for forced plumes
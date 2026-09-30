export ReducedGravity, ρ_from_g_prime


#########################################
"""
    ReducedGravity(ρ₀, ρₐ; g = 9.80665)

Calculate the reduced gravity for density `ρ₀` and the ambient `ρₐ`.
"""
function ReducedGravity(ρ₀, ρₐ; g = 9.80665)
    return g * (1 - ρ₀/ρₐ)
end


"""
    ρ_from_g_prime(g_prime, ρₐ; ρref=ρₐ, g = 9.80665)

Calculate the density `ρ` from the reduced gravity `g_prime` and the ambient density `ρₐ`.
"""
function ρ_from_g_prime(g_prime, ρₐ; ρref=ρₐ, g = 9.80665)
    return ρₐ - ρref*g_prime/g
end
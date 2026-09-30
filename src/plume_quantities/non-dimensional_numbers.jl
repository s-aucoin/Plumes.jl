export PlumeRe, PlumeRi, SourceRa, PlumeParameterΓ, Γ₀Definition


#########################################
"""
    PlumeRe(w, b; ν=1.0e-6)

Calculate the plume Reynolds number from the plume velocity `w`, plume radius `b`, and kinematic viscosity `ν`.
"""
function PlumeRe(w, b; ν=1.0e-6)
    return w * b / ν
end

"""
    PlumeRi(w, b, g_prime)

Calculate the plume Richardson number from the plume velocity `w`, plume radius `b`, and reduced gravity `g_prime`.
"""
function PlumeRi(w, b, g_prime)
    return g_prime * b / w^2
end

"""
    PlumeRi(Γ, κ, α)

Calculate the source Richardson number from the source parameter `Γ`, shape coefficient `κ`, and entrainment coefficient `α`.
"""
function PlumeRi(Γ; κ=2, α=0.11)
    return 8/(5κ) * α * Γ
end


"""
    SourceRa(ρₐ, ρ₀, h; ν=1.0e-6, κ=1.0e-9, g = 9.80665)

Calculate the plume Rayleigh number from the ambient density `ρₐ`, source density `ρ₀`, depth `h`, kinematic viscosity `ν`, and molecular diffusivity `κ`.
"""
function SourceRa(ρₐ, ρ₀, h; ν=1.0e-6, κ=1.0e-9, g = 9.80665)
    return (ReducedGravity(ρ₀, ρₐ; g=g) * h^3) / (κ * ν)
end


"""
    SourceRa(g_prime₀, h; ν=1.0e-6, κ=1.0e-9)

Calculate the source Rayleigh number from the reduced gravity `g_prime₀`, depth `h`, kinematic viscosity `ν`, and molecular diffusivity `κ`.
"""
function SourceRa(g_prime₀, h; ν=1.0e-6, κ=1.0e-9)
    return (g_prime₀ * h^3) / (κ * ν)
end

"""
    PlumeParameterΓ(w, b, g_prime; α=0.11)

Calculate the plume parameter Γ.

...
# Arguments
- `b`: Plume radius
- `w`: Vertical velocity
- `g_prime`: Reduced gravity
- `α`: Entranment coefficient
- `κ`: Factor determining plume shape. 1 for top-hat (circle), 2 for Gaussian.
...
"""
function PlumeParameterΓ(w, b, g_prime, α; κ=2)
    return (5κ * g_prime * b) / (8 * α * w^2)
end


"""
    Γ₀Definition(b₀, w₀, ρ₀, ρₐ; α=0.11, g = 9.80665)

Calculate the source plume parameter Γ₀.

...
# Arguments
- `b₀`: Source radius
- `w₀`: Source vertical velocity
- `ρ₀`: Souce density
- `ρₐ`: Ambient density
- `κ`: Factor determining plume shape. 1 for top-hat (circle), 2 for Gaussian.
- `α`: Entranment coefficient
- `g`: gravitational acceleration
...
"""
function Γ₀Definition(b₀, w₀, ρ₀, ρₐ; κ=2, α=0.11, g = 9.80665)
    return (5κ * ReducedGravity(ρ₀, ρₐ; g) * b₀) / (8 * α * w₀^2)
end
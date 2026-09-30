export BuoyancyFluxPerArea, MomentumFluxPerArea, VolumeFluxPerArea, TracerFluxPerArea


#########################################
"""
    BuoyancyFluxPerArea(w₀, g_prime₀, κ)

Calculate the per area buoyancy flux from the source velocity `w₀` and source reduced gravity `g_prime₀`.
`κ` determines the plume shape, 1 for top-hat, 2 for Gaussian.
"""
function BuoyancyFluxPerArea(w₀, g_prime₀, κ)
    return 1/κ * g_prime₀ * w₀
end


"""
    MomentumFluxPerArea(w₀, κ)

Calculate the per area momentum flux from the source velocity `w₀`.
`κ` determines the plume shape, 1 for top-hat, 2 for Gaussian.
"""
function MomentumFluxPerArea(w₀, κ)
    return 1/κ * w₀^2
end


"""
    VolumeFluxPerArea(w₀)

Calculate the per area volume flux from the source velocity `w₀`.
The volume flux does not depend on plume shape.
"""
function VolumeFluxPerArea(w₀)
    return w₀
end


"""
    TracerFluxPerArea(w₀, κ; C₀=1)

Calculate the per area tracer flux from the source velocity `w₀` and source concentration `C₀`.
`κ` determines the plume shape, 1 for top-hat, 2 for Gaussian.
"""
function TracerFluxPerArea(w₀, κ; C₀=1)
    return 1/κ * C₀ * w₀
end
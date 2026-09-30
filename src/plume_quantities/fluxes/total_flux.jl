export TotalBuoyancyFlux, TotalMomentumFlux, TotalVolumeFlux, TotalTracerFlux


#########################################
"""
    TotalBuoyancyFlux(w₀, b₀, g_prime₀, κ)

Calculate the total buoyancy flux from the source velocity `w₀`, source radius `b₀`, and source reduced gravity `g_prime₀`.
`κ` determines the plume shape, 1 for top-hat, 2 for Gaussian.
"""
function TotalBuoyancyFlux(w₀, b₀, g_prime₀, κ)
    return π/κ * g_prime₀ * w₀ * b₀^2
end


"""
    TotalMomentumFlux(w₀, b₀, κ)

Calculate the total momentum flux from the source velocity `w₀`, source radius `b₀`.
`κ` determines the plume shape, 1 for top-hat, 2 for Gaussian.
"""
function TotalMomentumFlux(w₀, b₀, κ)
    return π/κ * w₀^2 * b₀^2
end


"""
    TotalVolumeFlux(w₀, b₀)

Calculate the total volume flux from the source velocity `w₀`, source radius `b₀`.
Volume flux does not depend on plume shape
"""
function TotalVolumeFlux(w₀, b₀)
    return π * w₀ * b₀^2
end


"""
    TotalTracerFlux(w₀, b₀, κ; C₀=1)

Calculate the total tracer flux from the source velocity `w₀`, source radius `b₀`.
`κ` determines the plume shape, 1 for top-hat, 2 for Gaussian.
"""
function TotalTracerFlux(w₀, b₀, κ; C₀=1)
    return π/κ * C₀ * w₀ * b₀^2
end
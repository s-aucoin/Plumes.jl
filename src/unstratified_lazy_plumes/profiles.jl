export LazyPlumeW, LazyPlumeFarFieldW, PurePlumeW,
        LazyPlumeRadius, LazyPlumeBuoyancy, LazyPlumeTracerConcentration,
        LazyPlumeVolumeFlux, LazyPlumeMomentumFlux, EntrainmentRate


#########################################
"""
    LazyPlumeW(Γ, Γ₀, w₀)

Calculate the centerline vertical velocity of a lazy plume as a function of `Γ` and its source value `Γ₀` and source velocity `w₀`.
"""
    function LazyPlumeW(Γ, Γ₀, w₀)
        return w₀ * sqrt(Γ₀/Γ) * ((1 - Γ)/(1 - Γ₀))^(1/10)
    end


"""
    LazyPlumeFarFieldW(z, Γ₀, w₀, b₀)

Calculate the asymptotic far-field centerline vertical velocity of a lazy plume as a function of `ζ`, its source value `Γ₀`, source velocity `w₀`.
"""
    function LazyPlumeFarFieldW(ζ, Γ₀, w₀; N=10)
        return w₀ * (10/3)^(1/3) * Γ₀^(1/3) * (ζ - LazyVirtualSourcePosition(Γ₀; N=N))^(-1/3)
    end


"""
    PurePlumeW(ζ, b₀, w₀)

Calculate the centerline vertical velocity of a pure plume as a function of `ζ`, its source radius `b₀` and source velocity `w₀`.
"""
    function PurePlumeW(ζ, b₀, w₀)
        return w₀ * (10/3)^(1/3) * (10/3 + ζ)^(-1/3)
    end


"""
    LazyPlumeRadius(Γ, Γ₀, b₀)

Calculate the radius of a lazy plume as a function of `Γ`, its source value `Γ₀`, and source radius `b₀`.
"""
    function LazyPlumeRadius(Γ, Γ₀, b₀)
        return b₀ * (Γ/Γ₀)^(1/2) * ((1 - Γ)/(1 - Γ₀))^(-3/10)
    end


"""
    LazyPlumeBuoyancy(Γ, Γ₀, g_prime₀)

Calculate the buoyancy of a lazy plume as a function of `Γ`, its source value `Γ₀`, and source buoyancy `g_prime₀`.
"""
    function LazyPlumeBuoyancy(Γ, Γ₀, g_prime₀)
        return g_prime₀ * (Γ/Γ₀)^(1/2) * ((1 - Γ)/(1 - Γ₀))^(1/2)
    end


"""
    LazyPlumeTracerConcentration(Γ, Γ₀, g_prime₀)

Calculate the tracer concentration of a lazy plume as a function of `Γ`, its source value `Γ₀`, and source buoyancy `g_prime₀`.
"""
    function LazyPlumeTracerConcentration(Γ, Γ₀, C₀)
        return C₀ * (Γ/Γ₀)^(1/2) * ((1 - Γ)/(1 - Γ₀))^(1/2)
    end


"""
    LazyPlumeVolumeFlux(Γ, Γ₀, Q₀)
Calculate the volume flux of a lazy plume as a function of `Γ`, its source value `Γ₀`, and source volume flux `Q₀`.
"""
function LazyPlumeVolumeFlux(Γ, Γ₀, Q₀)
    return Q₀ * (Γ/Γ₀*(1-Γ₀)/(1-Γ))^(1/2)
end

"""
    LazyPlumeMomentumFlux(Γ, Γ₀, M₀)
Calculate the momentum flux of a lazy plume as a function of `Γ`, its source value `Γ₀`, and source momentum flux `Q₀`.
"""
function LazyPlumeMomentumFlux(Γ, Γ₀, M₀)
    return M₀ * ((Γ₀-1)/(Γ-1))^(2/5)
end

"""
    EntrainmentRate(Γ, Γ₀, Q₀, b₀; α=0.11)
"""
function EntrainmentRate(Γ, Γ₀, Q₀, b₀; α=0.11)
    return 2α*Q₀/b₀ * ((Γ₀-1)/(Γ-1))^(1/5)
end
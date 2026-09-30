using OrdinaryDiffEq

export CalculateMTTProfiles, CalculateLinearDensityProfile


#########################################
"""
    CalculateMTTProfiles(zs, w₀, b₀, g_prime₀, N², α, κ)

Calculate the profiles of w, b, and g' for a plume described with the stratified MTT equations at `zs`.

w₀, b₀, and g_prime₀ form the boundary conditions that the solver uses.
...
# Arguments
- `zs`: The spatial coordinates at which to evaluate the quantities.
- `w₀`: The source vertical velocity (z=0).
- `b₀`: The source radius (z=0).
- `g_prime₀`: The source reduced gravity (z=0).
- `N²`: The buoyancy frequency squared.
- `α`: The entrainment coefficient.
- `κ`: Factor determining plume shape. 1 for top-hat (circle), 2 for Gaussian.
...
"""
function CalculateMTTProfiles(zs, w₀, b₀, g_prime₀, N², α, κ)
    mttfunc(du, u, p, z) = mtt_fixedN²!(du, u, p, z, κ) # define the MTT model to solve

    params = [w₀, b₀, g_prime₀] # the boundary conditions for the ODE solver
    fixed = [α, N²]             # The constant parameters for the ODE solver

    prob = ODEProblem(mttfunc, params, (zs[1], zs[end]), fixed)
    sol = solve(prob, DefaultODEAlgorithm(), callback = cb)

    vals = reduce(hcat, sol.(zs)) # evaluate the solution at the specified zs

    return (w = vals[1,:], b = vals[2,:], g_prime = vals[3,:])
end



"""
    CalculateLinearDensityProfile(z, ρ₀, ρref, N²; g = 9.80665)

Calculate the density at `z` for a linear denisty profile with squared buoyancy frequency `N²`, initial density ρ(z=0) = `ρ₀`, and reference density ρref.
"""
function CalculateLinearDensityProfile(z, ρ₀, ρref, N²; g = 9.80665)
    return ρ₀ - ρref*N²/g*z
end
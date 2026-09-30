using OrdinaryDiffEq

export mttmodel, mttmodel_fixed_w₀, mttmodel_free_α


#########################################
## Define a callback for use in the ODE solver to terminate the integration if w gets too small (singularity) ##

w_buffer = 1e-5 # (m s⁻¹) buffer for the w value to terminate the integration at

function condition_w(u, t, integrator) # Event when condition(u,t,integrator) == 0
    w = u[1]
    return w - w_buffer
end

function affect_w!(integrator)
    terminate!(integrator)
end

cb = ContinuousCallback(condition_w, affect_w!)

#######################

"""
    mttmodel(z, u0, mttfunc, fixed)

Calculate the vertical velocity at `z` from boundary conditions `u0` for a given set of MTT plume equations `mttfunc` and `fixed` parameters.
"""
function mttmodel(z, u0, mttfunc, fixed)
    prob = ODEProblem(mttfunc, u0, (z[1], z[end]), fixed)
    sol = solve(prob, DefaultODEAlgorithm(), saveat = z, callback = cb)

    # Replace the negative w values with 0 since the plume would not go any higher in theory #
    w = reduce(hcat, sol.(z))[1, :]
    w[w .<= w_buffer] .= 0.0

    return w
end


"""
    mttmodel_fixed_w₀(z, u0, mttfunc, fixed)

Calculate the vertical velocity at `z` from boundary conditions `u0` for a given set of MTT plume equations `mttfunc` and `fixed` parameters.

For the case where the initial vertical velocity `w₀` is provided.
"""
function mttmodel_fixed_w₀(z, u0, mttfunc, fixed)
    w₀, α = fixed

    prob = ODEProblem(mttfunc, vcat(w₀, u0), (z[1], z[end]), α)
    sol = solve(prob, DefaultODEAlgorithm(), saveat = z, callback = cb)

    # Replace the negative w values with 0 since the plume would not go any higher in theory #
    w = reduce(hcat, sol.(z))[1, :]
    w[w .<= w_buffer] .= 0.0

    return w
end


"""
    mttmodel_free_α(z, u0, mttfunc)

Calculate the vertical velocity at `z` from boundary conditions `u0` for a given set of MTT plume equations `mttfunc` and `fixed` parameters.

For the case where the entrainment coefficient `α` is a free parameter.
"""
function mttmodel_free_α(z, u0, mttfunc)
    prob = ODEProblem(mttfunc, u0, (z[1], z[end]))
    sol = solve(prob, DefaultODEAlgorithm(), saveat = z, callback = cb)

    # Replace the negative w values with 0 since the plume would not go any higher in theory #
    w = reduce(hcat, sol.(z))[1, :]
    w[w .<= w_buffer] .= 0.0

    return w
end
export mtt!, mtt_fixedN²!, mtt_free_α!


#########################################
"""
    mtt!(du, u, p, z, κ)

Update the derivatives of the state vector components of the stratified MTT equations for a given plume shape (top-hat or Gaussian).

For the case where N² is a free parameter.
...
# Arguments
- `du`: The derivatives of the state vector components (w, b, g').
- `u`: The state vector (w, b, g', N²).
- `p`: The fixed parameters (α).
- `z`: The spatial coordinate.
- `κ`: Factor determining plume shape. 1 for top-hat (circle), 2 for Gaussian.
...
"""
function mtt!(du, u, p, z, κ)
    α = p
    w, b, g_prime, N² = u

    du[1] = κ*g_prime/w - 2w/b*α
    du[2] = 2α - κ*g_prime*b/(2w^2)
    du[3] = -(κ*N² + 2g_prime*α/b)

    return nothing
end


"""
    mtt_fixedN²!(du, u, p, z, κ)

Update the derivatives of the state vector components of the stratified MTT equations for a given plume shape (top-hat or Gaussian).

For the case where N² is a fixed parameter.
...
# Arguments
- `du`: The derivatives of the state vector components (w, b, g').
- `u`: The state vector (w, b, g').
- `p`: The fixed parameters (α, N²).
- `z`: The spatial coordinate.
- `κ`: Factor determining plume shape. 1 for top-hat (circle), 2 for Gaussian.
...
"""
function mtt_fixedN²!(du, u, p, z, κ)
    α, N² = p
    w, b, g_prime = u

    du[1] = κ*g_prime/w - 2w/b*α
    du[2] = 2α - κ*g_prime*b/(2w^2)
    du[3] = -(κ*N² + 2g_prime*α/b)

    return nothing
end


"""
    mtt_free_α!(du, u, p, z, κ)

Update the derivatives of the state vector components of the stratified MTT equations for a given plume shape (top-hat or Gaussian).

For the case where N² and α are free parameter.
...
# Arguments
- `du`: The derivatives of the state vector components (w, b, g').
- `u`: The state vector (w, b, g').
- `p`: The fixed parameters (α, N²).
- `z`: The spatial coordinate.
- `κ`: Factor determining plume shape. 1 for top-hat (circle), 2 for Gaussian.
...
"""
function mtt_free_α!(du, u, p, z, κ)
    w, b, g_prime, N², α = u

    du[1] = κ*g_prime/w - 2w/b*α
    du[2] = 2α - κ*g_prime*b/(2w^2)
    du[3] = -(κ*N² + 2g_prime*α/b)

    return nothing
end
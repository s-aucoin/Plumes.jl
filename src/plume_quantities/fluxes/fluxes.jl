export PlumeArea

include("total_flux.jl")
include("per_area_flux.jl")


#########################################
"""
    PlumeArea(b₀)

Area of the source of the plume with source radius `b₀`.
"""
function PlumeArea(b₀)
    return π*b₀^2
end
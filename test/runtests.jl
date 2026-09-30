using Plumes
using Test

@testset "Plumes.jl" begin
    include("misc.jl")
    include("plume_quantities/plume_quantities.jl")
    include("unstratified_lazy_plumes/unstratified_lazy_plumes.jl")
    include("stratified_mtt/stratified_mtt.jl")
end
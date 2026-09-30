@testset "Plume Fluxes" begin
    @testset "PlumeArea" begin
        @test isfinite(Plumes.PlumeArea(0.5))
    end

    include("total_flux.jl")
    include("per_area_flux.jl")
end

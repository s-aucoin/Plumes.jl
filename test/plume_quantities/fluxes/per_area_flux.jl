@testset "Per Area Flux" begin
    @test isfinite(BuoyancyFluxPerArea(1.0, 0.2, 2.0))

    @test isfinite(MomentumFluxPerArea(1.0, 2.0))

    @test isfinite(VolumeFluxPerArea(1.0))

    @test isfinite(TracerFluxPerArea(1.0, 2.0; C₀ = 0.7))
end

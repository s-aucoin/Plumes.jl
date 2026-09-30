@testset "Total Flux" begin
    @test isfinite(TotalBuoyancyFlux(1.0, 0.5, 0.2, 2.0))

    @test isfinite(TotalMomentumFlux(1.0, 0.5, 2.0))

    @test isfinite(TotalVolumeFlux(1.0, 0.5))

    @test isfinite(TotalTracerFlux(1.0, 0.5, 2.0; C₀ = 0.7))
end

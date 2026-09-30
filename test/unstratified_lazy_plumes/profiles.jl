@testset "Profiles" begin
    @test isfinite(LazyPlumeW(1.5, 2.0, 1.0))

    @test isfinite(LazyPlumeFarFieldW(1.0, 2.0, 1.0; N = 5))

    @test isfinite(PurePlumeW(1.0, 0.5, 1.0))

    @test isfinite(LazyPlumeRadius(1.5, 2.0, 0.5))

    @test isfinite(LazyPlumeBuoyancy(1.5, 2.0, 0.5))

    @test isfinite(LazyPlumeTracerConcentration(1.5, 2.0, 0.5))

    @test isfinite(LazyPlumeVolumeFlux(1.5, 2.0, 1.0))

    @test isfinite(LazyPlumeMomentumFlux(1.5, 2.0, 1.0))

    @test isfinite(EntrainmentRate(1.5, 2.0, 1.0, 0.5; α = 0.11))
end

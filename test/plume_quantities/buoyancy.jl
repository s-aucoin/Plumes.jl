@testset "Buoyancy" begin
    @test isfinite(ReducedGravity(1.05, 1.0; g = 9.81))

    @test isfinite(ρ_from_g_prime(0.2, 1.0; ρref = 1.0, g = 9.81))
end

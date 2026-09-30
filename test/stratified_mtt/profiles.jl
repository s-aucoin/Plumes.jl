@testset "Profiles" begin
    vals = CalculateMTTProfiles(0.0:0.1:1.0, 0.5, 0.2, 0.1, 1e-4, 0.11, 2.0)
    @test vals.w isa AbstractVector
    @test vals.b isa AbstractVector
    @test vals.g_prime isa AbstractVector
    @test all(isfinite, vals.w)
    @test all(isfinite, vals.b)
    @test all(isfinite, vals.g_prime)

    @test isfinite(CalculateLinearDensityProfile(0.5, 1.0, 1.0, 1e-4; g = 9.81))
end

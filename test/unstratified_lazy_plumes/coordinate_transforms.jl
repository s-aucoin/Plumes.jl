@testset "Coordinate Transforms" begin
    @test isfinite(z2ζ(1.0, 0.5; α = 0.11))
    @test isfinite(ζ2z(1.0, 0.5; α = 0.11))

    @test isfinite(Plumes.integral_factor_lazy(2.0))
    @test isfinite(Plumes.integral_factor_forced(0.5))
    @test isfinite(Plumes.integrand_lazy(10, nothing))
    @test isfinite(Plumes.integrand_forced(0.5, nothing))

    @test isfinite(Plumes.Γ_integral(1.5, 2.0))

    @test isfinite(Γ2ζ(1.5, 2.0))
    @test isfinite(ζ2Γ(1.0, 2.0))
end

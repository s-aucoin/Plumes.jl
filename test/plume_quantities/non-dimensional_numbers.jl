@testset "Non-dimensional Numbers" begin
    @test isfinite(PlumeRe(1.0, 0.5; ν = 1e-6))

    @test isfinite(PlumeRi(1.0, 0.5, 0.2))

    @test isfinite(SourceRa(1.0, 1.05, 10.0; ν = 1e-6, κ = 1e-9, g = 9.81))
    @test isfinite(SourceRa(0.2, 10.0; ν = 1e-6, κ = 1e-9))

    @test isfinite(PlumeParameterΓ(1.0, 0.5, 0.2, 0.11; κ = 2))

    @test isfinite(Γ₀Definition(0.5, 1.0, 1.05, 1.0; κ = 2, α = 0.11, g = 9.81))
end

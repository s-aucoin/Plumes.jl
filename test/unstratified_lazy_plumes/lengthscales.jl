@testset "Lengthscales" begin
    @test isfinite(LazyPlumeLengthScale(0.5; α = 0.11))

    @test isfinite(LazyVirtualSourcePosition(2.0; N = 5))
end

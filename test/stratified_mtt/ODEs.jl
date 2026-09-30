@testset "ODEs" begin
    @testset "mtt!" begin
        du = zeros(3)
        u = [0.2, 0.1, 0.05, 1e-4]
        mtt!(du, u, 0.11, 0.5, 2.0)
        @test all(isfinite, du)
    end

    @testset "mtt_fixedN²!" begin
        du = zeros(3)
        u = [0.2, 0.1, 0.05]
        mtt_fixedN²!(du, u, [0.11, 1e-4], 0.5, 2.0)
        @test all(isfinite, du)
    end

    @testset "mtt_free_α!" begin
        du = zeros(3)
        u = [0.2, 0.1, 0.05, 1e-4, 0.11]
        mtt_free_α!(du, u, nothing, 0.5, 2.0)
        @test all(isfinite, du)
    end
end

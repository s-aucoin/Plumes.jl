@testset "Fit Models" begin
    @testset "condition_w" begin
        @test isfinite(Plumes.condition_w([1e-4, 0.1, 0.2], 0.0, nothing))
    end

    @testset "mttmodel" begin
        z = 0.0:0.1:1.0
        u0 = [0.2, 0.1, 0.05, 1e-4]
        mttfunc = (du, u, p, z) -> mtt!(du, u, p, z, 2)
        model(x, p) = mttmodel(x, p, mttfunc, 0.11)
        w = model(z, u0)
        @test all(isfinite, w)
    end

    @testset "mttmodel_fixed_N²" begin
        z = 0.0:0.1:1.0
        u0 = [0.2, 0.1, 0.05]
        mttfunc = (du, u, p, z) -> mtt_fixedN²!(du, u, p, z, 2)
        model(x, p) = mttmodel(x, p, mttfunc, [0.11, 1e-4])
        w = model(z, u0)
        @test all(isfinite, w)
    end

    @testset "mttmodel_fixed_w₀" begin
        z = 0.0:0.1:1.0
        u0 = [0.1, 0.05, 1e-4]
        mttfunc = (du, u, p, z) -> mtt!(du, u, p, z, 2)
        model(x, p) = mttmodel_fixed_w₀(x, p, mttfunc, (0.01, 0.11))
        w = model(z, u0)
        @test all(isfinite, w)
    end

    @testset "mttmodel_free_α" begin
        z = 0.0:0.1:1.0
        u0 = [0.3, 0.1, 0.02, 1e-4, 0.11]
        mttfunc_free = (du, u, p, z) -> mtt_free_α!(du, u, p, z, 2)
        model(x, p) = mttmodel_free_α(x, p, mttfunc_free)
        w = model(z, u0)
        @test all(isfinite, w)
    end
end

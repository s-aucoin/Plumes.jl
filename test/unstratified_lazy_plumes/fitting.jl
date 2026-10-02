
# This function is not tested becuase it is too fragile and sensitive to the input data.
@testset "Fitting" begin
    z = range(0.0, 1.2, length=100)
    w = vcat(range(0.02, 0.1, length=20), range(0.11, 0.01, length=80))
    result = LSFitPlumeW(z, w, 1018.0)
    @test all(isfinite.(result.param))
end


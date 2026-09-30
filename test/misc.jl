using Dates

@testset "misc" begin
    time = DateTime(2024, 1, 1, 0):Hour(1):DateTime(2024, 1, 1, 4)
    variable = collect(1.0:5.0)
    sttimes = [DateTime(2024, 1, 1, 0), DateTime(2024, 1, 1, 2)]
    endtimes = [DateTime(2024, 1, 1, 1), DateTime(2024, 1, 1, 3)]

    result = MeanCTDVariable(time, variable, sttimes, endtimes)

    @test result isa NamedTuple
    @test isfinite(result.mean_var)
    @test isfinite(result.std_var)
end

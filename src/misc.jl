using Dates
using ExtraStats

export MeanCTDVariable


#########################################
"""
    MeanCTDVariable(time, variable, sttimes, endtimes; max_depth=nothing, depth=nothing)

Find the mean and standard deviation of `variable` during the `time` periods specified by `sttimes` and `endtimes`.

Optionally remove values below a `depth` threshold `max_depth` (could actually be any variable, not just depth).
"""
function MeanCTDVariable(time, variable, sttimes, endtimes; max_depth=nothing, depth=nothing)

    ## Find the index in time where the desired ranges start and end ##
    stidx = last.(map(x -> findmin(abs.(Dates.value.(time .- x))), sttimes))
    enidx = last.(map(x -> findmin(abs.(Dates.value.(time .- x))), endtimes))

    ## Make into a vector of ranges ##
    section_idxs = map(x -> x[1]:x[2], collect(zip(stidx, enidx)))

    ## extract the variable during the sections ##
    var_sections = map(x -> variable[x], section_idxs)

    ## Combine each section into one vector ##
    var_sections_reduced = reduce(vcat, var_sections)


    ## Optionally Remove the values that are below a specified depth ##
    if max_depth != nothing
        if depth == nothing
            error("Must provide depth")
        end

        depth_sections = map(x -> depth[x], section_idxs)      # extract the depth during the sections
        depth_sections_reduced = reduce(vcat, depth_sections)  # Combine into one vector

        toodeep = findall(depth_sections_reduced .> max_depth) # the values that are below the deepest spring depth

        deleteat!(var_sections_reduced, toodeep)
    end


    ## Mean and std of the whole thing ##
    mean_var = nanmean(var_sections_reduced)
    std_var = nanstd(var_sections_reduced)

    return (; mean_var, std_var)
end
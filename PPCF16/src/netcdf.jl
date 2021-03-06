using NetCDF

function read_ncdf(filename::AbstractString,vars...)

    ncid = NetCDF.open(filename);

    if length(vars) == 0
        vars = [k for k in keys(ncid.vars)]
    end

    variables = Dict{AbstractString,Any}()

    for v in vars
        newVar = Dict([(v,NetCDF.readvar(ncid,v))])
        merge!(variables,newVar)
    end

    NetCDF.close(ncid)
    if length(keys(variables)) == 1
        key = collect(keys(variables))
        return variables[key[1]]
    else
        return variables
    end

end

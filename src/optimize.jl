using Optim

function optimize!(gp::GP)
    function mll(hyp::Vector{Float64})
        set_params!(gp.k, hyp)
        update!(gp)
        return -gp.mLL
    end
    function dmll!(hyp::Vector{Float64}, grad::Vector{Float64})
        set_params(gp.k, hyp)
        update!(gp)
        grad[:] = -gp.dmLL
    end
    function mll_and_dmll!(hyp::Vector{Float64}, grad::Vector{Float64})
        set_params!(gp.k, hyp)
        update!(gp)
        grad[:] = -gp.dmLL
        return -gp.mLL
    end
    init = params(gp.k)              #Initial hyperparameter values
    results=optimize(mll,dmll!,init,method=:nelder_mead) #Run optimizer
    print(results)
end

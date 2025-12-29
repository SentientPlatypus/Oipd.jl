include(joinpath(@__DIR__, "Oipdf.jl"))

using .Oipdf


println("this is running top_level_test.jl")

savedir = "examples/example_plots"
ticker ="AAPL"

p_below = prob_below(ticker, 250.0, get_closest_expiry(ticker), savedir)
p_above = prob_at_or_above(ticker, 250.0, get_closest_expiry(ticker), savedir)

println("Probability that $(ticker) will be below 250.0 at expiry: $(p_below)")
println("Probability that $(ticker) will be above 250.0 at expiry: $(p_above)")
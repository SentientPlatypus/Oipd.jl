using Oipdf
using Test
using Plots

@testset "Oipd.jl tests" begin
    include("../test/bstests.jl")
    include("../test/svi_test.jl")
    @test Oipdf.greet_your_package_name() == "Hello Oipd!"
    @test Oipdf.greet_your_package_name() != "Hello world!"
end


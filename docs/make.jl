push!(LOAD_PATH,"../src/")
using Documenter, OptionsImpliedPDF

makedocs(
    sitename="OptionsImpliedPDF.jl",
    pages = [
        "Home" => "index.md",
        "Technical Documentation" => "technical.md",
        "Handwritten Notes" => "notes.md"
    ]
)
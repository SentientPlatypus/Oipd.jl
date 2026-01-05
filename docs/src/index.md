# OptionsImpliedPDF.jl Documentation

```@meta
CurrentModule = OptionsImpliedPDF
```

# Overview

OptionsImpliedPDF.jl is a Julia package that extracts risk-neutral probability distributions from options market data, revealing the market's collective expectations about future asset price movements.

Under the efficient market hypothesis, these option-implied probabilities represent the most informed estimates available of potential price outcomes, derived from the wisdom of market participants.

This package was inspired by the existing Python library [OIPD](https://github.com/tyrneh/options-implied-probability/blob/main/README.md).

![Risk-Neutral Probability Density Function](https://raw.githubusercontent.com/SentientPlatypus/OptionsImpliedPDF.jl/main/examples/example_plots/AAPL/2026-01-09/7_pdf_numerical.png)

*Example output: Risk-neutral probability density function extracted from AAPL options data*

## Features

- **Real-time Options Data**: Fetches live options chains from Yahoo Finance
- **Black-Scholes Pricing**: Complete implementation with implied volatility calculation
- **SVI Model**: Stochastic Volatility Inspired model for volatility smile fitting
- **Risk-Neutral Probabilities**: Calculates probabilities of price movements using risk-neutral density
- **Breeden-Litzenberger**: Numerical density estimation from option prices
- **Visualization**: Built-in plotting functions for analysis and debugging
- **Arbitrage Detection**: Automatic checking for model consistency and arbitrage opportunities

## Installation

To install OptionsImpliedPDF.jl, use the Julia package manager:

```julia
using Pkg
Pkg.add("OptionsImpliedPDF")
```

## Quick Start

```@example
using ..OptionsImpliedPDF

# Get closest available expiration date
closest_expiry = get_closest_expiry("AMD")

# Calculate probability that AMD will be below $200 at expiration

prob = prob_below("AMD", 200.0, closest_expiry)

# Calculate probability that AMD will be at or above $250
prob_above = prob_at_or_above("AMD", 250.0, closest_expiry)

println("Probability AMD is below $(200.0) on $(closest_expiry) is $(prob). The probability it is at or above that is $(prob_above)")
```

## Usage

The package provides high-level functions to compute probabilities from options data:

- `prob_below(ticker, strike_price, expiry, savedir=nothing)`: Returns the probability of the underlying asset being below the strike price at expiry.
- `prob_at_or_above(ticker, strike_price, expiry, savedir=nothing)`: Returns the probability of the underlying asset being at or above the strike price at expiry.
- `get_closest_expiry(ticker)`: Returns the closest available expiration date for the given ticker.

When `savedir` is provided, the functions save various plots (parity checks, IV smiles, SVI fits, PDFs) to subdirectories organized by ticker and expiry.

## API Reference

```@autodocs
Modules = [OptionsImpliedPDF]
```

## Examples

For detailed examples, see the `examples/` directory in the repository, which includes:

- Plot generation for various tickers and expiries
- Comparison of fitted models
- Visualization of implied PDFs

## Contributing

Contributions are welcome! Please see the repository's issue tracker and pull request guidelines.

## License

This project is licensed under the MIT License - see the [LICENSE](https://github.com/SentientPlatypus/OptionsImpliedPDF.jl/blob/main/LICENSE) file for details.

```@contents
```
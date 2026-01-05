# Technical Documentation

## Overview

OptionsImpliedPDF.jl is a Julia package implementing advanced options pricing models and risk-neutral probability analysis. The package combines real-time market data with sophisticated mathematical models to provide accurate pricing and risk assessment tools.

## Process Overview

The process of generating the PDFs and CDFs is as follows:

1. **Data Acquisition**: For an underlying asset, options data along the full range of strike prices are read from a source file to create a DataFrame. This gives us a table of strike prices along with the last or mid price each option sold for.

2. **Put-Call Parity Preprocessing**: Apply put-call parity to create synthetic call prices from out-of-the-money put prices, reducing noise from illiquid in-the-money quotes.

3. **OTM Filtering**: Restrict to out-of-the-money options only, keeping calls with strike prices above the current spot price and using synthetic calls constructed from OTM puts via parity.

   ![Paritized Options Data](https://raw.githubusercontent.com/SentientPlatypus/OptionsImpliedPDF.jl/main/examples/example_plots/AAPL/2026-01-09/1_paritized_plot.png)

4. **Implied Volatility Calculation**: Using the Black-Scholes-Merton pricing model, convert option prices into implied volatilities (IV). IVs are solved using Newton's method with analytical derivatives.

   ![Implied Volatility Smile](https://raw.githubusercontent.com/SentientPlatypus/OptionsImpliedPDF.jl/main/examples/example_plots/AAPL/2026-01-09/2_iv_smile.png)

5. **Gaussian Smoothing**: Apply Gaussian kernel smoothing to the implied volatilities to reduce noise and outliers before surface fitting.

   ![Smoothed IV Smile](https://raw.githubusercontent.com/SentientPlatypus/OptionsImpliedPDF.jl/main/examples/example_plots/AAPL/2026-01-09/3_iv_smile_smoothed.png)
   ![Filtered Smoothed IV Smile](https://raw.githubusercontent.com/SentientPlatypus/OptionsImpliedPDF.jl/main/examples/example_plots/AAPL/2026-01-09/4_iv_smile_smoothed_filtered.png)

6. **Volatility Surface Fitting**: Fit the smoothed implied-volatility smile using the SVI (Stochastic Volatility Inspired) model. During optimization, constrain the raw parameters ($b \geq 0$, $|\rho| \leq \rho_{\text{bound}} < 1$, $\sigma \geq \sigma_{\text{min}}$) and enforce the Gatheral-Jacquier minimum-variance condition $a + b\sigma\sqrt{1-\rho^2} \geq 0$. After calibration, evaluate the butterfly diagnostic $g(k)$ on an extended log-moneyness grid; if $\min g < 0$ a CalculationError is raised.

   ![SVI Fitted IV Smile](https://raw.githubusercontent.com/SentientPlatypus/OptionsImpliedPDF.jl/main/examples/example_plots/AAPL/2026-01-09/5_iv_svi.png)

7. **Price Curve Generation**: From the fitted volatility smile, use the Black-Scholes-Merton model to generate a continuous curve of option prices along the full range of strike prices.

   ![Repriced Option Prices](https://raw.githubusercontent.com/SentientPlatypus/OptionsImpliedPDF.jl/main/examples/example_plots/AAPL/2026-01-09/6_price_vs_strike_repriced.png)

8. **PDF Extraction**: From the continuous price curve, use numerical differentiation to compute the second derivative of call prices with respect to strike. The second derivative multiplied by the discount factor $e^{r\tau}$ gives the risk-neutral probability density function (Breeden-Litzenberger formula).

   ![Risk-Neutral PDF](https://raw.githubusercontent.com/SentientPlatypus/OptionsImpliedPDF.jl/main/examples/example_plots/AAPL/2026-01-09/7_pdf_numerical.png)

9. **CDF Calculation**: Once we have the PDF, calculate the cumulative distribution function through numerical integration.

## Mathematical Framework

For more details, my handwritten notes can be seen in the `/notes` folder.
- [Implied Probability](https://github.com/SentientPlatypus/OptionsImpliedPDF.jl/blob/main/notes/Implied%20Probability.pdf)
- [Black Scholes](https://github.com/SentientPlatypus/OptionsImpliedPDF.jl/blob/main/notes/Black%20Scholes%20Merton.pdf)

### Black-Scholes Model

The package implements the classic Black-Scholes model for European options:
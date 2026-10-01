# Library

All functions exported by this package are listed below.


## Library Contents
```@contents
Pages = ["library.md"]
Depth = 3
```

## Index
```@index
```


## Functions
### Plume Quantities
```@docs
PlumeRe
PlumeRi
SourceRa
PlumeParameterΓ
Γ₀Definition
ReducedGravity
ρ_from_g_prime
```

#### Fluxes
```@docs
PlumeArea
TotalBuoyancyFlux
TotalMomentumFlux
TotalVolumeFlux
TotalTracerFlux
BuoyancyFluxPerArea
MomentumFluxPerArea
VolumeFluxPerArea
TracerFluxPerArea
```

### Unstratified Lazy Plume Equations
```@docs
z2ζ
ζ2z
Γ2ζ
ζ2Γ
LazyPlumeLengthScale
LazyVirtualSourcePosition
LSFitPlumeW
LazyPlumeW
LazyPlumeFarFieldW
PurePlumeW
LazyPlumeRadius
LazyPlumeBuoyancy
LazyPlumeTracerConcentration
LazyPlumeVolumeFlux
LazyPlumeMomentumFlux
EntrainmentRate
```

#### Unexported
```@docs
Plumes.Γ_integral
```


### Stratified MTT Equations
```@docs
mtt!
mtt_fixedN²!
mtt_free_α!
mttmodel
mttmodel_fixed_w₀
mttmodel_free_α
CalculateMTTProfiles
CalculateLinearDensityProfile
```

### Misc
```@docs
MeanCTDVariable
```


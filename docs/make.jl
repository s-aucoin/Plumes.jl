using Documenter
using Plumes

makedocs(
    sitename = "Plumes",
    format = Documenter.HTML(),
    modules = [Plumes],
    remotes = nothing,
    pages = ["Home" => "index.md",
            "Plume Quantities" => "plume_quantities/plume_quantities.md",
            "Unstratified Lazy Plumes" => "unstratified_lazy_plumes/unstratified_lazy_plumes.md",
            "Stratified MTT" => "stratified_mtt/stratified_mtt.md",
            "Miscellaneous" => "misc.md",
            "Library" => "library.md"]
)

# Documenter can also automatically deploy documentation to gh-pages.
# See "Hosting Documentation" and deploydocs() in the Documenter manual
# for more information.
deploydocs(
    repo = "github.com/s-aucoin/Plumes.jl.git",
    versions = nothing
)

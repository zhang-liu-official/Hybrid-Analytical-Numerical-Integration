Pkg.add("Gadfly")
Pkg.add("Plots")


using Gadfly
using Plots

Gadfly.plot(x=[8, 4, -7, -6, 1, 6, 4, -2],
     y=[-2, -7, -4, 6, 8, 4, -4, 4],
     Geom.polygon(preserve_order=true, fill=false))

Gadfly.plot(x=[8, 4, -7, -6, 1, 6],
     y=[-2, -7, -4, 6, 8, 4],
      Gadfly.Geom.polygon(preserve_order=true, fill=false))

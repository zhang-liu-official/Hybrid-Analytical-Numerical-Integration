Pkg.add("Gadfly")
Pkg.add("Plots")
using Gadfly
using Plots
plot(x=[8, 4, 2, -7, -6, 1, 6, 4, -2],
     y=[-2, -7, -4, 6, 7, 8, 4, -4, 4],
     Geom.polygon(preserve_order=true, fill=false))

 plot(x=[8, 4, -7, -6, 1, 6],
      y=[-2, -7, 6, 7, 8, 4],
      Geom.polygon(preserve_order=true, fill=false))

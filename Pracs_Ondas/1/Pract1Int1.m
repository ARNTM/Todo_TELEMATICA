syms a r p e %declaramos las variables como simbólicas
int(p*a^3/(3*e*r^2),r,a,inf) %integral definida respecto a r, de a a infinito
simplify((p/(6*e))*(a^2-r^2))-(a^2*p/(3*e))%potencial en r en el exterior

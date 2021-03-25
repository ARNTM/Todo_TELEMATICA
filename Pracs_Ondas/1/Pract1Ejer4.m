syms p a r e %definimos todas las variables como simbólicas
int(((p*(a^2 - r^2))/(6*e) - (a^2*p)/(3*e))*r^2,r) %calculamos la integral indefinida
int(((p*(a^2 - r^2))/(6*e) - (a^2*p)/(3*e))*r^2,r,0,a) %integral de 0 a a
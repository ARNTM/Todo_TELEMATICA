# Andrés Ruz Nieto
# 02-ejercicios_introduccion.py

import numpy as np


def esprimo(n):
    ''' Devuelve "True" si el numero es primo, y "False" si no lo es '''
    for i in range(2, n):
        if n % i == 0:
            return False
    return True


n = int(input("Introduce un número entero: "))
print()
print("##########")

# FORMA INCIAL - EJERCICIO 1
#final = 0
# for i in range(n):
#    final += 4 * (((-1) ** i) / (2 * i + 1))
#print("Resultado del ejercicio 1: ", final)

print("Resultado del ejercicio 1: ", end=" ")
print(
    np.array(
        [4 * (((-1) ** i) / (2 * i + 1)) for i in range(n)]
    ).sum()
)
print("##########")

print()

print("##########")
print("Resultado del ejercicio 2: ")
for i in range(11):
    print(i * n)

print("##########")

print()

print("##########")
print("Resultado del ejercicio 3: ")
n = int(input("Número de filas del patrón: "))
for i in range(n + 1):
    for j in range(i):
        print(j + 1, end=" ")
    print()
print("##########")

print()

print("##########")
print("Resultado del ejercicio 4: ")
primo = False
n = int(input("Introduce un número: "))
for i in range(2, n):
    if n % i == 0:
        print(f"No es primo, el número {i} es divisor")
        primo = True
        break
if not primo:
    print(f"El número {n} es primo")
print("##########")

print()

print("##########")
print("Resultado del ejercicio 5: ")
n = int(input("Introduce un número: "))
print(esprimo(n))
print("##########")

print()

print("##########")
print("Resultado del ejercicio 6: ")
n = int(input("Introduce un número: "))
for i in range(n+1):
    if esprimo(i):
        print(i)
print("##########")

print()

print("##########")
print("Resultado del ejercicio 7: ")
personas = {'Pedro': 28, 'María': 21, 'Marta': 22}
esperanza_adicional = {28: 53.4, 21: 65.6, 22: 64.5}

# FORMA INICIAL
# for persona,edad in personas.items():
#    personas_esperanza[persona] = esperanza_adicional[edad]

personas_esperanza = {
    persona: esperanza_adicional[edad] + edad for persona, edad in personas.items()
}

print(personas_esperanza)

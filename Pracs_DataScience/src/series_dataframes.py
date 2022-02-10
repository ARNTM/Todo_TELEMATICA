import pandas as pd
edades = pd.Series(
   [28, 21, 22, 25],
   index=['Pedro', 'María', 'Marta', 'Mateo'],
   name='edad'
)
esperanza_adicional = pd.Series(
   [53.4, 65.6, 64.5],
   index=['Pedro', 'María', 'Marta'],
   name='esperanza'
)
#print(edades + esperanza_adicional);

# print(edades.mean())
# print(edades.std())

# esperanza_vida = edades + esperanza_adicional

# esperanza_vida.dropna(inplace=True)  # Quita los NaN, si inplace = true, modifica la Serie

# print(esperanza_vida)

# s1 = pd.Series(
#     [3, 2.5, -1, 10],
#     index = ['a', 'b', 'c', 'b']
# )
# s2 = pd.Series(
#     [1, 0.5, 2],
#     index = ['b', 'c', 'b']
# )
# print(s1 + s2);

personas = pd.DataFrame(
    [[28, 53.4], [21, 65.6], [22, 64.5]],
    index=['Pedro', 'María', 'Marta'],
    columns=['edad', 'esperanza_adicional']
)

personas = pd.DataFrame(
    {
        'edad' : [28, 21, 22],
        'esperanza_adicional' : [53.4, 65.6, 64.5]
    },
    index=['Pedro', 'María', 'Marta']
)

personas = pd.DataFrame(
    {
        'edad': edades,
        'esperanza_adicional': esperanza_adicional
    }
)


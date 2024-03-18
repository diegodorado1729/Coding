# Python

## Consideraciones Generales
-No es necesario declarar las variables ni decir que tipo son

## Variables
- `=`: Operador asignacion
-

# Pandas
- `import pandas as pd`: importar la libreria
- `pd.read_csv()`: funcion para leer datos en un DataFrame a partir de un CSV
- `.shape`: comando para ver cuan grande es el DataFrame resultante. El formato es `(number1, number2)`
  donde `number1` es el numero de valores a lo largo de `number2` columnas
- `.head()`: comando para ver que hay en el DataFrame resultante
- Hay dos objetos principales: `DataFrame` y `Series`
  
## DataFrame
Una DataFrame es una tabla. Esta conformada por una serie de arreglos con entradas individuales, cada una de las cuales tiene
un cierto valor. Cada entrada corrsponde a una fila (o record) y a una columna.
- `pd.DataFrame({'nombre-columna1': ['text1', 'text2'], 'nombre-columna2': ['text3.', 'text4']})`: sintaxis basica del DataFrame

- Si queremos cambiar el indice agregamos el parametro `index` dentro del parentesis:
`pd.DataFrame({'Bob': ['I liked it.', 'It was awful.'], 'Sue': ['Pretty good.', 'Bland.']}, index=['Product A', 'Product B'])`

## Series
Una Serie es una secuencia de datos, una lista. Se podria pensar que una Serie es una DataFrame de una sola columna

- `pd.Series([30, 35, 40], index=['2015 Sales', '2016 Sales', '2017 Sales'], name='Product A')`: sintaxis de una Serie
      2015 Sales    30
      2016 Sales    35
      2017 Sales    40
      Name: Product A, dtype: int64


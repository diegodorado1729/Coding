# Pandas
- `import pandas as pd`: importar la libreria
- `pd.read_csv()`: funcion para leer datos en un DataFrame a partir de un CSV
- `.shape`: comando para ver cuan grande es el DataFrame resultante. El formato es `(number1, number2)`
  donde `number1` es el numero de valores a lo largo de `number2` columnas
- `.head()`: comando para ver que hay en el DataFrame resultante
- Hay dos objetos principales: `DataFrame` y `Series`
- `dataframe_archive.to_csv("archive_name")`: para guardar el DataFrame como csv en el disco
  
## DataFrame
Una DataFrame es una tabla. Esta conformada por una serie de arreglos con entradas individuales, cada una de las cuales tiene
un cierto valor. Cada entrada corrsponde a una fila (o record) y a una columna.
- `pd.DataFrame({'nombre-columna1': ['text1', 'text2'], 'nombre-columna2': ['text3.', 'text4']})`: sintaxis basica del DataFrame

- Si queremos cambiar el indice agregamos el parametro `index` dentro del parentesis:
`pd.DataFrame({'Bob': ['I liked it.', 'It was awful.'], 'Sue': ['Pretty good.', 'Bland.']}, index=['Product A', 'Product B'])`

## Series
Una Serie es una secuencia de datos, una lista. Se podria pensar que una Serie es una DataFrame de una sola columna

- `pd.Series([30, 35, 40], index=['2015 Sales', '2016 Sales', '2017 Sales'], name='Product A')`: sintaxis de una Serie
    ```
    2015 Sales    30
    2016 Sales    35
    2017 Sales    40
    Name: Product A, dtype: int64
    ```
- Los nombres y los valores combiene colocarlos juntos en variables, para luego usar `pd.Series` de la siguiente manera
  ```
     sales=['2015 Sales', '2016 Sales', '2017 Sales']
     valores=[30, 35, 40]
     pd.Series(valores, index=sales, name 'Product A')
    ```
-`ejem1.serie1` `ejem1['serie1']`: formas de extraer una serie `serie1` del DataFrame `ejem1`
  - Si queremos un elemento en especifico: `ejem1['serie1'][34]`

## Indexacion, Seleccion, Asignacion

### Indexacion y Seleccion

Pandas tiene sus propios operadores accessor: `loc` y `iloc`. Ambos operadores son primero fila, segundo columna, contrario
a la sintaxis usual en python.

#### iloc
- `iloc`: operador indexacion basado en la indice de los datos
- `reviews.iloc[0]`: selecciona la primera fila del DataFrame
- `reviews.iloc[:, 0]`: selecciona la primera columna del DataFrame
- `reviews.iloc[:3, 0]`: selecciona la primera columna pero solamente la primera, segunda y tercera fila.
- `reviews.iloc[1:3, 0]`: selecciona la primera columna pero solamente la segunda y tercera fila.
  -Es posible tambien usar una lista: `reviews.iloc[[0, 1, 2], 0]`
- `reviews.iloc[-5:]`: selecciona las ultimas 5 filas

#### loc
- `loc`: operador indexacion basado en el label de los datos
- `reviews.loc[0, 'country']`: selecciona el elemento de la fila `0` y la columna `country`
- `loc` es util cuando tenemos informacion en las columnas descritas por su label

Cabe destacar que en `iloc` el primer elemento del rango esta incluido y ultimo esta excluido. Sin embargo en `loc`
el primer y ultimo elemento estan incluidos.

#### Manipulacion del indice
- `set_index("title")`: coloca la columna `"title"` como indice del DataFrame

#### Seleccion Condicional
- `reviews.country == 'Italy'`: a partir de DataFrame reviews se obtiene una seccion de `True`/`False` de la columna country,
dependiendo si el elemento es `Italy` o no.
- Si se quieren solo estos datos usamos `loc`: `reviews.loc[reviews.country == 'Italy']` que extrae la informacion relevante
asosiada a los elementos de la columna `country` que sean `Italy`
- Si se quiere añadir alguna otra condicion para filtrar los datos se usa `&` y `|`
    `reviews.loc[(reviews.country == 'Italy') & (otra-condicion) | (otra-condicion) & ...]`
- 

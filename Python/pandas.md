# Pandas
- `import pandas as pd`: importar la libreria
- `pd.read_csv()`: funcion para leer datos en un DataFrame a partir de un CSV
- `.shape`: comando para ver cuan grande es el DataFrame resultante. El formato es `(number1, number2)`
  donde `number1` es el numero de valores a lo largo de `number2` columnas
- `.head()`: comando para ver que hay en el DataFrame resultante
- Hay dos objetos principales: `DataFrame` y `Series`
- `dataframe_archive.to_csv("archive_name")`: para guardar el DataFrame como csv en el disco
- `replace()`: este comando permite reemplazar un valor por otro
    - `reviews.taster_twitter_handle.replace("@kerinokeefe", "@kerino")`: en este caso para toda la columna `'taster_twitter_..'`
      los valores `"@kerinokeefe"` son reemplazados por `"kerino"`
  
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
- `isin(['column1','column2',...])`: selecciona los datos de las columnas `column1` y `column2` si estan en el DataFrame
- `isnull()`: selecciona los valores vacios (`NaN`)
- `notnull()`: selecciona los valores no vacios (`NaN`)

### Asignacion de datos
- `data['column1'] = 'text'`: asigna un valor constante `'text'` a la columna `column1`
- `data['index_backwards'] = range(len(reviews), 0, -1)`: asigna valores iterativos ed la forma:
  ```
  0         129971
  1         129970
           ...  
  129969         2
  129970         1
  Name: index_backwards, Length: 129971, dtype: int64
  ```

## Sumario de Funciones

### describe()
- `name_data.column1.describe()`: genera un sumario de alto nivel de los atributos de la columna dada
- `describe()` es 'type-aware', es decir que el output cambia basado en el tipo de datos que haya en el input.

Si son numeros el output tendra una pinta asi
```
count    129971.000000
mean         88.447138
             ...      
75%          91.000000
max         100.000000
Name: points, Length: 8, dtype: float64
```
Si los datos son tipo string el output va a tener la pinta
```
count         103727
unique            19
top       Roger Voss
freq           25514
Name: taster_name, dtype: object
```

#### mean() y median()
- `name_data.column1.mean()`: da la media de los valores del input, en este caso la columna `column1`
- `name_data.column1.median()`: da la mediana de los valores del input, en este caso la columna `column1`

#### unique() y value_counts()
- `name_data.column1.unique()`: devuelve una lista de los valores unicos de la columna `column1`

- `name_data.column1.value_counts()`: devuelve una lista de valores unicos y cuan a menudo ocurren en la columna `column1`

#### idxmax
- `.idxmax`: encuentra el indice del valor maximo en una serie o DataFrame
    - ej: `max_index = data.idxmax()`: encuentra el indice del valor maximo de `data`

## Maps
- `map(lambda p: funtion)`: reescribe los valores p del input a los valores que indique `funtion`
   - ej: `reviews.points.map(lambda p: p - 5)`: le resta 5 a los valores de la columna `points` de los datos `reviews`
- `apply(funtion, axis='columns')`: aplica la funcion `funtion` a cada fila de los datos
- `apply(funtion, axis='index')`: aplica la funcion `funtion` a cada columna de los datos

Otras formas que pandas entiende para reescribir los valores de una columna:

```
review_points_mean = reviews.points.mean()
reviews.points - review_points_mean
```
Pandas ve esta expresion y entiende que tiene que restarle el valor de `review_points_mean` a cada elemento de la columna `points`

Esta expresion tambien la entience Pandas:
```
>>reviews.country + " - " + reviews.region_1

0            Italy - Etna
1                     NaN
               ...       
129969    France - Alsace
129970    France - Alsace
Length: 129971, dtype: object
```

## Agrupacion: groupby()

- `reviews.groupby('points').points.count()`: crea una serie con los mismos valores unicos de la columna `points`. Luego coloca en la 
primera columna el valor de esos puntos y luego cuanta cuantos hay repetidos. El comando `value_counts()` es una forma mas corta de
esta operacion de `groupby()`
```
points
80     397
81     692
      ... 
99      33
100     19
Name: points, Length: 21, dtype: int64
```
Es posible hacer esto mismo usando la funcion `size()` de la siguente manera:
`reviews.groupby('points').size()`

- `reviews.groupby('points').price.min()`: crea una serie donde una colemna son los puntos del mismo valor y la otra es el precio minimo
```
  points
80      5.0
81      5.0
       ... 
99     44.0
100    80.0
Name: price, Length: 21, dtype: float64
```
El comando `groupby()` se puede combinar tambien con el comando `apply()` para extraer alguna parte que nos interesa de la serie generada
Por otro lado, tambien es posible escoger dos columnas: `groupby(['column1', 'column2',...])`
El comando `agg()` puede ser util combinarlo con `groupby()` si se quieren aplicar varias funciones a la vez. Por ejemplo:
```
reviews.groupby(['country']).price.agg([len, min, max])

              len	   min	  max
country			
Argentina     3800 	4.0	   230.0
Armenia        2	  14.0	 15.0
...	           ...	 ...	  ...
Ukraine	       14  	6.0	    13.0
Uruguay	       109 	10.0	 130.0
```

### Indice Multiple
-`data_name.reset_index()`: le coloca indice a el DataFrame

## Sorting

Al tener un grupo/DataFrame en muchas ocaciones se tiene que organizar por algun aprametreo que se quiera.
Para ello, se va a usar los comandos `sort_...`

- `.sort_values(by='len')`: ordena la columna seleccionada (en este caso `'len'`) en orden ascendente
- `.sort_values(by='len', ascending=False)`: ordena la columna seleccionada (en este caso `'len'`) en orden descendente
- `.sort_indexby='len')`: ordena el DataFrame en base al indice
- `.sort_values(by=['country','len'])`: ordena la columna seleccionada (en este caso `'country'`) en orden ascendente y
  luego ordena cada seccion segun la columna `'len'` de manera ascendente

## Tipos de Datos y valores perdidos

### Dtypes
El tipo de datos de una columna de un DataFrame es conocido como `dtype`

- `data.column1.dtype`: se obtiene el tipo de datos de la columna 1
- `data.dtypes`: se obtiene el tipo de cada unoa de las columans del DataFrame
- `data.column1.astype('type')`: cambia el tipo de la columna 1 a el tipo `'type'`

### Data perdida (Missing Data)
Los valores perdidos, o missing data, estas dados por el valor `NaN` "Not a Number" el cual es tipo `float64`. Pandas
provee elgunos metodos especificos para missing data. Por ejemplo:

- `reviews[pd.isnull(reviews.country)]`
- `fillna()`: es un comando que permite reemplazar valores de missing data
    - `reviews.region_2.fillna("Unknown")`: en este caso los `NaN` son reemplazados por `Unknown`

## Renombrado

- `rename()`: permite renombrar el indice y/o columna deseada
    - `reviews.rename(columns={'points': 'score'})`: en este caso se renombra la columna `'points'` a `'score'`
    - `reviews.rename(index={0: 'firstEntry', 1: 'secondEntry'})`: en este caso se renombran los indices 0 y 1
- `rename_axis()`: renombra el nombre del atributo de las filas y/o columnas
    - `reviews.rename_axis("wines", axis='rows')`: se cambia el nombre del atributo de las filas a `'wines'`
    - `reviews.rename_axis("fields", axis='columns')`: se cambia el nombre del atributo de las columnas a `'fields'`

## Combinar

- `concat()`: une dos DataFrame
    - `pd.concat([data1, data2])`: sintaxis del `concat()`
- `join()`: concatena dos DataFrame que tengan un indice en comun
```
left = canadian_youtube.set_index(['title', 'trending_date'])
right = british_youtube.set_index(['title', 'trending_date'])

left.join(right, lsuffix='_CAN', rsuffix='_UK')
```
Los comandos `lsuffix` y `rsuffix` se usan ya que los nombre de las columnas de estos DataFrame son iguales, asi
se puede diferenciar entre ambos datos. De lo contrario no son necesarios.
  
      
    























# Sintaxis de comandos intermedios en Julia

## Variables y Tipos de Datos

### Declaración de Variables
`nombre_variable = valor`

### Tipos de Datos
# Enteros
```
x = 10
typeof(x)  # => Int64
```

# Flotantes
```
y = 3.14
typeof(y)  # => Float64
```

# Cadenas de Caracteres
```
cadena = "Hola"
typeof(cadena)  # => String
```

# Booleanos
```
verdadero = true
falso = false
typeof(verdadero)  # => Bool
```

## Estructuras de Control

### Condicional if-else
```
if condicion
    # código si la condición es verdadera
else
    # código si la condición es falsa
end
```

### Bucles for
```
for i in 1:5
    println(i)
end
```

### Bucles while
```
i = 1
while i <= 5
    println(i)
    i += 1
end
```

## Funciones

### Declaración de Funciones
```
function nombre_funcion(parametro1, parametro2)
    # cuerpo de la función
    return resultado
end
```

### Llamada a Funciones
```
nombre_funcion(valor1, valor2)
```
## Colecciones

### Vectores
```
vector = [1, 2, 3, 4, 5]
```
### Matrices
```
matriz = [1 2 3; 4 5 6; 7 8 9]
```
### Tuplas
```
tupla = (1, "Hola", true)
```
### Diccionarios
```
diccionario = Dict("a" => 1, "b" => 2, "c" => 3)
```
## Operaciones Básicas

### Operaciones Matemáticas
```
x + y   # Suma
x - y   # Resta
x * y   # Multiplicación
x / y   # División
x ^ y   # Exponenciación
```
### Operaciones Lógicas
```
&&  # AND lógico
||  # OR lógico
!   # NOT lógico
```
### Comparaciones
```
==  # Igual a
!=  # Diferente de
<   # Menor que
>   # Mayor que
<=  # Menor o igual que
>=  # Mayor o igual que
```